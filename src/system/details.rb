require_relative 'os'
require_relative 'linux'
require_relative 'windows'

module System
  class Details
    def self.new
      if System::Os.linux?
        System::Linux.new
      elsif System::Os.windows?
        System::Windows.new
      else
        # shoot for the stars by trying linux
        System::Linux.new
      end
    end
  end
end
