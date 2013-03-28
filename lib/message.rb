
class Message

  attr_reader :nick, :chat, :chatroom_id

  def initialize(attributes)
    @nick = attributes[:nick]
    @chat = attributes[:chat]
    @chatroom_id = attributes[:chatroom_id]
  end

  def say
    response = Faraday.post(SERVER,{:message => {:nick => @nick, :chat => @chat, :chatroom_id => @chatroom_id }})
  end

  def self.get_chats(chatroom_id)
    response = Faraday.get(SERVER, {:message => {:chatroom_id => chatroom_id}})
    if response.body 
      messages = JSON.parse(response.body,:symbolize_names => true)
      messages.map { |message_hash| Message.new(message_hash[:message]) }
    else
      false
    end
  end

end