
require_relative 'src/files.rb'
require_relative 'src/processes.rb'
require_relative 'src/connections.rb'



file = Files.new("test_file.txt")
file.create
file.modify
file.delete

process = Processes.new("ruby examples/simple_ruby_file.rb -r -u -b -y")
process.start

port = 80
ip_address = Socket.getnameinfo(Socket.sockaddr_in(port, 'google.com'))
connections = Connections.new(ip_address.first, port)
connections.send_tcp("GET / HTTP/1.0\r\n\r\n")