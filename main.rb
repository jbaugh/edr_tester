
require_relative 'src/files.rb'
require_relative 'src/processes.rb'



file = Files.new("data/foo.txt")
file.create
file.modify
file.delete

process = Processes.new("ruby examples/simple_ruby_file.rb -r -u -b -y")
process.start

