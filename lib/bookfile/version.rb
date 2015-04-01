# encoding: utf-8

module Bookfile
  VERSION = '0.2.0'

  def self.banner
    "bookfile/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end
end

## add module alias
BookFile = Bookfile

