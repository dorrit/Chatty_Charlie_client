
class Message

  attr_reader :nick, :chat

  def initialize(attributes)
    @nick = attributes[:nick]
    @chat = attributes[:chat]
  end

  def say
    response = Faraday.post(SERVER,{:nick => @nick, :chat => @chat}.to_json)
  end

  def get_chats
    response = Faraday.get(SERVER)
    if response.body 
      messages = JSON.parse(response.body,:symbolize_name => true)
      messages.map { |message_hash| Message.new(message_hash) }
    else
      false
    end
  end

end