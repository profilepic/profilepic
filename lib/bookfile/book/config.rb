# encoding: utf-8

module Bookfile


class BookConfig
  def initialize( hash={} )
    @hash = hash
  end
  
  def templates_dir
    @hash[:templates_dir]
  end
end


end # module Bookfile
