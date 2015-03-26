# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_beer.rb


require 'helper'

class TestBeer < MiniTest::Test

  def test_beer
    book_templates_unzip_dir = './tmp/book-beer'

    bookfile = Bookfile::Bookfile.load_file( './test/bookfile/beer.rb' )

    bookfile.download   # download book packages (templates n scripts)
    bookfile.unzip( book_templates_unzip_dir ) 

    bookfile.prepare( book_templates_unzip_dir )
    bookfile.connect

    bookfile.build( book_templates_unzip_dir )

    assert true  # if we get here - test success
  end

end # class TestWorld

