require_relative 'linux'

module System
  class Details
    def self.new
      System::Linux.new
    end
  end
end
