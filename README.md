
# EDR Tester

This small program is meant to simulate normal computer activity in a controlled manner, so that an EDR can be tested. Each action will be logged with details which can be used to confirm the functionality and accuracy of the EDR. The log format is JSON and will look something like:

```JSON
{"process_start_time":1655327078,"process_user":"jarrettbaugh","process_name":"ruby","process_command_line":"ruby examples/simple_ruby_file.rb -r -u -b -y","pid":1527198}
```
## How to Use
There are three main categories of actions:
1. Files
2. Processes
3. Connections

In order to use these, there is a service object which can be initialized:
```ruby
file = Files.new("test_file.txt")
```
and can be used such as:
```ruby
file.create # creates a file
file.modify # appends some data to the file
file.delete # deletes the file
```
There is some basic error checking which will notify (via STDOUT) - for example if the file does not exist when you try to modify or delete, or if there is a problem actually creating the file.
The `Processes` and `Connections` features work in a similar way:
```ruby
process = Processes.new("ruby examples/simple_ruby_file.rb -r -u -b -y")
process.start # executes the command
```
and
```ruby
port = 80
ip_address = Socket.getnameinfo(Socket.sockaddr_in(port, 'google.com'))
connections = Connections.new(ip_address.first, port)
connections.send_tcp("GET / HTTP/1.0\r\n\r\n") # opens the connection and sends tcp data
```
The first 2 lines for the `Connections` example are not necessary, but allowed for a simple example.

## Supported OSes
This program was tested on **Windows** 10, and **Linux** PopOS 20.04

## Notes
- The IP returned is local IP as opposed to the public IP. The only way I know how to access the public IP is to make an external connection, which would/could influence the EDR test.
- I tried to avoid using any gems directly (although I did research and try to understand how they work) 
