###
#  to run use
#     ruby -I ./lib sandbox/test_wizard.rb



require 'cocos'
require 'profilepic'

pp YEOLDEPUNK


buf = render_options( YEOLDEPUNK )


write_text( './tmp/yeoldepunk.html', buf )


pp ORDINALPUNK

buf = render_options( ORDINALPUNK )


write_text( './tmp/ordinalpunk.html', buf )


puts "bye"
