require_relative 'linux'
require_relative 'windows'

module System
  class Details
    def self.new
      if os == 'linux'
        System::Linux.new
      elsif os == 'windows'
        System::Windows.new
      else
        # shoot for the stars by trying linux
        System::Linux.new
      end
    end


    def self.os
      if RUBY_PLATFORM =~ /cygwin/ || ENV['OS'] == 'Windows_NT'
        'windows'
      elsif RbConfig::CONFIG['host_os'].include?('linux')
        'linux'
      else
        'unknown'
      end
    end
  end
end
