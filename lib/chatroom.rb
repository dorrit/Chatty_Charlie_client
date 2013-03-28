class Chatroom

  attr_reader :id, :room

  def initialize(attributes)
    @room = attributes[:chatroom]
    @id = attributes[:id]
  end

  def create_room
    response = Faraday.post(CHATSERVER,{:chatroom => {:chatroom => @room}})
  end

  def self.get_rooms
    response = Faraday.get(CHATSERVER)
    if response.body 
      chatrooms = JSON.parse(response.body,:symbolize_names => true)
      chatrooms.map { |chatroom_hash| Chatroom.new(chatroom_hash[:chatroom]) }
    else
      false
    end
  end


end

