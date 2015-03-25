# encoding: utf-8

module Bookfile

class Bookfile

  include LogUtils::Logging

  ## convenience method - use like Bookfile.load_file()
  def self.load_file( path='./Bookfile' )
    # Note: return datafile (of course, NOT the builder)
    # if you want a builder use Bookfile::Builder ;-)
    builder = Builder.load_file( path )
    builder.datafile
  end

  ## another convenience method - use like Bookfile.load()
  def self.load( code )
    # Note: return datafile (of course, NOT the builder)
    # if you want a builder use Bookfile::Builder ;-)
    builder = Builder.load( code )
    builder.datafile
  end



  attr_reader :packages
  attr_reader :databases
  attr_reader :books

  def initialize
    @packages  = []    # only allow single package  - why, why not??
    @databases = []    # only allow single database - why, why not??
    @books     = []    # only allow single book     - why, why not??
  end


  def download
    puts "[bookfile] dowload book packages"
    @packages.each do |package|
      package.download
    end
  end

  ###
  ## todo/fix - add unzip_dir as an option/config to constructor - why, why not??
  ##  location needs to get (re)used in prepare too
  ##  for now pass along unzip_dir again ???
  def unzip( unzip_dir )
    puts "[bookfile] unzip book packages"
    ### fix: for multiple packages use a number?? - how to make path unique
    ##     for now is ./book 
    @packages.each do |package|
      package.unzip( unzip_dir )
    end
  end


=begin
  def setup
    puts "[bookfile] setup database connections n models"
    @databases.each do |database|
      database.setup
    end
  end
=end

  def connect
    puts "[bookfile] connect to database(s)"
    @databases.each do |database|
      database.connect
    end
  end


  def prepare( unzip_dir )
    @databases.each do |database|
      database.prepare    ## require models and include in builder/page ctx
    end
    @packages.each do |package|
      package.prepare( unzip_dir )     ## require helpers and include in builder/page ctx
    end
  end


  def build( unzip_dir )
    puts "[bookfile] build books"
    @books.each do |book|
      book.build( unzip_dir )
    end
  end



  def dump
##    ## for debugging dump datasets (note: will/might also check if zip exits)
##    logger.info( "[datafile] dump datasets (for debugging)" )
##    @datasets.each do |dataset|
##      dataset.dump()
##    end
  end


end # class Bookfile
end # module Bookfile

