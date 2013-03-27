require 'timeout'

time = 0
input = nil
puts "Press c and then enter to compose a chat:"
until input == 'c'
  puts time += 1
  begin
    Timeout.timeout(1) do
      input = gets.chomp
    end
  rescue
  end
end

puts 'Type your message and press enter:'
message = gets.chomp
puts 'Nice message. Good-bye!'