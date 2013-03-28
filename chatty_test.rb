require 'timeout'

time = 0
input = nil
puts "Press enter to compose a chat:"
until input == ''
  puts "\e[H\e[2J" # clears the screen
  puts time += 1
  begin
    Timeout.timeout(1) {input = gets.chomp}
  rescue Timeout::Error # catches the exception from the timeout
  end
end

puts 'Type your message and press enter:'
message = gets.chomp
puts 'Nice message. Good-bye!'