require 'socket'

require_relative 'activity_logger'
require_relative 'system/details'

class Connections
  attr_reader :hostname, :port

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
  end

  def send_tcp(data)
    s = TCPSocket.open(hostname, port)
    s.print(data)
    s.close
    log_activity('tcp', data)
  end

  private

  def log_activity(protocol, data)
    details = System::Details.new
    pid = Process.pid

    entry = {
      timestamp: Time.now.to_i,
      process_user: details.process_user(pid),
      process_name: details.process_name(pid),
      process_command_line: details.process_command_line(pid),
      pid: pid,
      destination_address: "#{hostname}:#{port}",
      source_address: "#{details.current_ip_address}:#{port}",
      protocol: protocol,
      data_amount: data.size,
    }
    ActivityLogger.new.log(entry)
  end
end
