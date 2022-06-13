module System
  class Linux
    def boot_time
      File.read("/proc/stat")[/btime.*/].split.last.to_i rescue 0
    end

    def process_start_time(pid)
      # source https://man7.org/linux/man-pages/man5/proc.5.html
      stat_data = `cat /proc/#{pid}/stat`.split
      # stat file returns in jiffies, which is 0.01 second
      time_since_boot = stat_data[21].to_i / 100
      boot_time + time_since_boot
    end

    def process_user(pid)
      `ps -p #{pid} -o user=`.strip
    end

    def process_name(pid)
      `ps -p #{pid} -o comm=`.strip
    end

    def process_command_line(pid)
      `ps -p #{pid} -o args=`.strip
    end
  end
end
