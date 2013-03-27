SERVER = 'http://localhost:3000/messages/'
require 'json'
require 'faraday'
require 'timeout'

def welcome
  puts "Welcome to Chatty. Type /help for help, /exit to exit."
  puts "To stop listening and start chatting, type /chat"
  command_line
end


def command_line  
  input = nil
  nick = nil
  until input == '/exit'
    print "#{nick} > "
    input = poll_server
    input_split = input.split(' ')
    command = input_split.shift
    command_info = input_split.join(' ')
    

    case command
    when '/help'
      puts "Here are the commands:\n\n"
      puts "  /exit - exit the program."
      puts "  /help - this help menu."
      puts "  /nick <nickname> to set a nickname."
      puts "  / - start chatting"
      # puts "\nTo send a message just start typing.\n\n"
    when '/nick'
      nick = arg_string
      puts "Welcome to Chatty, #{nick}."
    when '/'
      send_message(nick, input)
    else

    end
  end
end

  def send_message(nick, chat)
    puts 'Type your message and press enter to send:'
    chat = gets.chomp
    message = Message.new({:chat => chat, :nick => nick)
    message.say
  end

def poll_server
  time = 0
  input = nil
  puts "Press '/' and then enter to compose a chat:"
  until input == '/'
    puts time += 1
    begin
      Timeout.timeout(1) do
        input = gets.chomp
      end
    rescue
    end
  end
  input
end

welcome