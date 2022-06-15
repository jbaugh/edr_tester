require_relative 'activity_logger'
require_relative 'system/details'

class Processes
  attr_reader :command

  def initialize(command)
    @command = command
  end

  def start
    pid = Process.spawn({}, command)
    log_activity(pid)
    Process.wait(pid)
  end

  private

  def log_activity(pid)
    details = System::Details.new

    entry = {
      process_start_time: details.process_start_time(pid),
      process_user: details.process_user(pid),
      process_name: details.process_name(pid),
      process_command_line: details.process_command_line(pid),
      pid: pid
    }
    ActivityLogger.new.log(entry)
  end
end
