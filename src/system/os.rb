module System
  class Os
    def self.windows?
      RUBY_PLATFORM =~ /cygwin/ || ENV['OS'] == 'Windows_NT'
    end

    def self.linux?
      RbConfig::CONFIG['host_os'].include?('linux')
    end
  end
end
