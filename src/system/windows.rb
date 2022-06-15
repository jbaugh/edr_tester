require_relative 'os'

require 'socket'
require 'date'
require 'win32ole' if System::Os.windows?

module System
  class Windows
    def process_start_time(pid)
      DateTime.parse(win32ole(pid).CreationDate).to_time.to_i
    end

    def process_user(pid)
      pid_info = `tasklist /V /FI "PID eq #{pid}"`.split
      # this feels brittle, but I could not find a better way
      pid_info[31]
    end

    def process_name(pid)
      win32ole(pid).Name
    end

    def process_command_line(pid)
      win32ole(pid).CommandLine
    end

    def current_ip_address
      ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
      ip.ip_address
    end

    private

    def win32ole(pid)
      @_win32ole ||= {}
      return @_win32ole[pid] if @_win32ole[pid]

      wmi = WIN32OLE.connect("winmgmts://#{Socket.gethostname}/root/cimv2")
      wmi.InstancesOf("Win32_Process").each do |wproc|
        next if pid && wproc.ProcessId != pid
        
        @_win32ole[pid] = wproc
        return wproc
      end
    end
  end
end
