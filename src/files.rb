require_relative 'activity_logger'
require_relative 'system/details'

require 'fileutils'

class Files
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def create
    FileUtils.touch(file_path)
    if File.exist?(file_path)
      log_activity('create')
    else
      puts "File create failed for #{file_path}"
    end
  end

  def modify
    if File.exist?(file_path)
      File.open(file_path, 'w') { |f| f.puts Time.now.to_i }
      log_activity('modify')
    else
      puts "File modify failed for #{file_path} -- file does not exist"
    end
  end

  def delete
    if File.exist?(file_path)
      if File.delete(file_path) > 0
        log_activity('delete', timestamp: Time.now.to_i)
      else
        puts "File delete failed for #{file_path} -- file exists, but could not delete file"
      end
    else
      puts "File delete failed for #{file_path} -- file does not exist"
    end 
  end

  private

  def log_activity(activity_type, opts = {})
    details = System::Details.new
    pid = Process.pid

    entry = {
      timestamp: opts[:timestamp] || File.mtime(file_path).to_i,
      full_path: File.expand_path(file_path),
      activity: activity_type,
      process_user: details.process_user(pid),
      process_name: details.process_name(pid),
      process_command_line: details.process_command_line(pid),
      pid: pid
    }
    ActivityLogger.new.log(entry.inspect)
  end
end
