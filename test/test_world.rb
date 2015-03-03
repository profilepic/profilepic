# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_world.rb


require 'helper'

class TestWorld < MiniTest::Test

  def test_world
    builder = Bookfile::Builder.load_file( './test/bookfile/world.rb' )
    bookfile = builder.bookfile
    bookfile.setup
    bookfile.build

    assert true  # if we get here - test success
  end

end # class TestWorld

