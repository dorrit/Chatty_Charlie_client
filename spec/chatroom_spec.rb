require 'spec_helper'

describe Chatroom do  
 let(:room) { 'PinkMadonna' }
 let(:chatroom) { Chatroom.new({ :room => room, :id => 1 }) }

  context 'readers' do
    it 'returns the chatroom through #room' do
      chatroom.room.should eq room
    end

    it 'returns the chatroom id through #id' do
      chatroom.id.should eq 1
    end
  end

  context '#initialize' do
    it 'initializes with a single hash argument' do 
      chatroom.should be_an_instance_of Chatroom
    end
  end

  context '#create_room' do 
    it 'POSTs a chat to the chatroom' do 
      stub = stub_request(:post, CHATSERVER).
              to_return(:status => 200, :body => "")
      chatroom.create_room
      stub.should have_been_requested
    end
  end

  context '.get_rooms' do
    it 'GETs the last 20 chats from the chatroom' do
      stub = stub_request(:get, "#{CHATSERVER}").
              to_return(:status => 200, :body => "" )
      Chatroom.get_rooms
      stub.should have_been_requested
    end
  end
end

