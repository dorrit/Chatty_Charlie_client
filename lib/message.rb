
class Message

  attr_reader :nick, :chat, :chatroom

  def initialize(attributes)
    @nick = attributes[:nick]
    @chat = attributes[:chat]
    @chatroom = attributes[:chatroom]
  end

  def say
    response = Faraday.post(SERVER,{:message => {:nick => @nick, :chat => @chat, :chatroom => @chatroom }})
  end

  def self.get_chats
    response = Faraday.get(SERVER)
    if response.body 
      messages = JSON.parse(response.body,:symbolize_names => true)
      messages.map { |message_hash| Message.new(message_hash[:message]) }
    else
      false
    end
  end

end