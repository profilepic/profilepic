# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_world_templates.rb


require 'helper'

class TestWorldTemplates < MiniTest::Test

  def test_unzip
    builder = Bookfile::Builder.load_file( './test/bookfile/world.rb' )
    bookfile = builder.bookfile
    
#    bookfile.download   # download book packages (templates n scripts)
#    bookfile.unzip      # unzip book packages (template)

    bookfile.prepare  # require models n helpers

#    bookfile.connect
#    bookfile.build

    assert true  # if we get here - test success
  end

end # class TestWorldTemplates

