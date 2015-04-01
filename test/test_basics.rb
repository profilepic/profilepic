# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_basics.rb

require 'helper'

class TestBasics < MiniTest::Test

  def test_banner

    banner = "bookfile/#{Bookfile::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"

    assert_equal banner, Bookfile.banner
    assert_equal banner, BookFile.banner   ## check module alias

  end

end # class Basics
