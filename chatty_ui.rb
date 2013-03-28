SERVER = 'http://localhost:3000/messages/'
CHATSERVER =  'http://localhost:3000/chatrooms/'
require 'json'
require 'faraday'
require 'timeout'
require './lib/message'
require './lib/chatroom'

def welcome
  puts "\nWelcome to Chatty. Type /help for help, /exit to exit."
  puts "\nTo stop listening and start chatting, type /chat"
  puts "Enter your nickname"
  @nick = gets.chomp
  join_chatroom
  menu
  command_line
end


def join_chatroom
  puts "\nHere is a list of rooms:"
  puts "   ID \t   CHATROOM"
  chatrooms = Chatroom.get_rooms
  chatrooms.each { |chatroom| puts "   #{chatroom.id} \t #{chatroom.room}"}
  puts "\nChoose a number to join a chatroom? (or press 'c' to create a new one.)"
  input = gets.chomp
  if input == 'c' 
     add_chatroom 
   else
    @chatroom_id = input
    chatrooms.each { |chatroom| @chatroom = chatroom if chatroom.id == input.to_i }
  end
end

def add_chatroom
 puts  "What is the name of the chatroom you would like to add?"
 new_room = gets.chomp
 chatroom = Chatroom.new({:chatroom => new_room})
 chatroom.create_room
 puts "Your new room has been created! Press enter to continue."
 gets.chomp
end

def command_line  
  input = nil
  nick = nil
  until input == '/exit'
    poll_server
    puts "\nPlease enter your command (or /help for a menu of commands) or start typing to chat."
    print "#{@chatroom_id} - #{@nick} > "
    input = gets.chomp
    input_split = input.split(' ')
    command = input_split.shift
    command_info = input_split.join(' ')
    
    puts command 

    case command
    when '/help'
      menu
    when '/nick'
      @nick = command_info
      puts "Welcome to Chatty, #{nick}."
    when '/listen'
      poll_server
    when '/join'
      join_chatroom
    when /^\/.*$/
    else
      send_message(@nick, input)
    end
  end
end

  def menu
    puts "Here are the commands:\n\n"
    puts "  /exit - exit the program."
    puts "  /help - this help menu."
    puts "  /nick <nickname> to set a nickname."
    puts "  /chat - start chatting"
    puts "  /listen - start listening to the server"
    puts "  /join - join or add a different chatroom"
  end

  def send_message(nick, chat)
    #puts 'Type your message and press enter to send:'
    #chat = gets.chomp
    message = Message.new(:chatroom_id => @chatroom_id, :chat => chat, :nick => (nick ? nick : 'anonymous'))
    message.say
  end

def poll_server
  time = 0
  input = nil
  until input == '/'
    puts "\e[H\e[2J"
    puts "Press '/' and enter for command mode.\n\n"
    puts "You are currently talking in the '#{@chatroom.room}' chat room. Give 'em hell!\n\n"
    Message.get_chats(@chatroom_id).each { |message| puts "#{message.chatroom_id} - #{message.nick} > #{message.chat}"}
    begin
      Timeout.timeout(1) {input = gets.chomp}
    rescue Timeout::Error
    end
  end
  input
end




welcome