# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_football.rb


require 'helper'

class TestFootball < MiniTest::Test

  def test_football
    book_templates_unzip_dir = './tmp/book-football'

    bookfile = Bookfile::Bookfile.load_file( './test/bookfile/football.rb' )

    bookfile.download   # download book packages (templates n scripts)
    bookfile.unzip( book_templates_unzip_dir ) 

    bookfile.prepare( book_templates_unzip_dir )
    bookfile.connect

    bookfile.build( book_templates_unzip_dir )

    assert true  # if we get here - test success
  end

end # class TestFootball

