require 'spec_helper'

describe Message do 
  let(:nick) { 'Seamus' }
  let(:chat) { 'The website is down!' }
  let(:message) { Message.new({ :nick => nick, :chat => chat }) }

  context 'readers' do
    it 'returns the message through #chat' do
      message.chat.should eq chat
    end

    it 'returns the nickname through #nick' do
      message.nick.should eq nick
    end
  end

  context '#initialize' do
    it 'initializes with a single hash argument' do 
      message.should be_an_instance_of Message
    end
  end

  context '#say' do 
    it 'POSTs a chat to the chatroom' do 
      stub = stub_request(:post, SERVER).
              to_return(:status => 200, :body => "")
      message.say
      stub.should have_been_requested
    end
 end

  context '.get_chats' do
    it 'GETs the last 20 chats from the chatroom' do
      stub = stub_request(:get, SERVER).
              to_return(:status => 200, :body => "" )
      message.get_chats
      stub.should have_been_requested
    end
  end

end