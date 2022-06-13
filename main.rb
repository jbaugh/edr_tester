
require_relative 'src/files.rb'



file = Files.new("data/foo.txt")
file.create
file.modify
file.delete