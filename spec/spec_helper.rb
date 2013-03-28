SERVER = 'http://localhost:3000/messages/'
CHATSERVER =  'http://localhost:3000/chatrooms/'
VALID_GET_RESPONSE = "[{\"message\":{\"chat\":\"you blew it dude!\",\"chatroom\":\"Mickey Mouse Club\",\"created_at\":\"2013-03-27T16:29:58Z\",\"id\":1,\"nick\":\"mickey\",\"updated_at\":\"2013-03-27T16:29:58Z\"}},{\"message\":{\"chat\":\"No, YOU blew it, dude!\",\"chatroom\":\"Mickey Mouse Club\",\"created_at\":\"2013-03-27T17:52:42Z\",\"id\":2,\"nick\":\"Bobert\",\"updated_at\":\"2013-03-27T17:52:42Z\"}},{\"message\":{\"chat\":\"SHUT UP SHUT UP! I have a plan!\",\"chatroom\":\"Mickey Mouse Club\",\"created_at\":\"2013-03-27T17:54:02Z\",\"id\":3,\"nick\":\"Georgangelo\",\"updated_at\":\"2013-03-27T17:54:02Z\"}}]"

require 'rspec'
require 'json'
require 'webmock/rspec'
require 'faraday'
require 'pry'
require 'pry-debugger'

require 'message'
require 'chatroom'