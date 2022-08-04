###
#  to run use
#     ruby -I ./lib sandbox/test_server.rb



ENV['RACK_ENV'] ||= 'development'
puts "RACK_ENV=#{ENV['RACK_ENV']}"


require 'profilepic'


Profilepic.main


puts "bye"
