#encoding: utf-8


module Bookfile

class Builder

  ## include LogUtils::Logging

  def self.load_file( path )
    code = File.read( path )
    self.load( code )
  end

  def self.load( code )
    builder = Builder.new
    builder.instance_eval( code )
    builder
  end


  attr_reader :bookfile

  def initialize
    puts "starting new bookfile; lets go"
    @bookfile = Bookfile.new
  end


  def package( name, opts={} )
    puts "package '#{name}'"
    @bookfile.packages << BookPackage.new( name, opts )
  end

  def world( opts={} )
    puts "world opts: #{opts.inspect}"
    @bookfile.databases << World.new( opts )
  end

  def book( opts={}, &block )
    puts "book opts: #{opts.inspect}"
    @bookfile.books << BookDef.new( opts, block )
  end

end # class Builder

end # module Bookfile

