require 'json'

class ActivityLogger
  def log(msg)
    open('log/log.json', 'a') do |f|
	  f.puts msg.to_json
	end
  end
end
