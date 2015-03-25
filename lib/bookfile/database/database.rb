# encoding: utf-8


module Bookfile

class Database
  def initialize( db_config )
    @db_config = db_config
  end

  def connect
    print "  connecting..."
    ActiveRecord::Base.establish_connection( @db_config )
    puts "OK"
  end

  def setup   ## use connect/prepare - why, why not??
    prepare   # step 1: prepare - require and include models
    connect   # step 2: connect
  end
end



class WorldDef < Database   ## change to WorldDatabase or DatabaseWorld - why, why not???
  def initialize( db_config )  ## check - if it works by default (no initialze specfied)
    super
  end

  def prepare   ## change to require - why, why not??
    puts "setup world: #{@db_config.inspect}"

    res = require 'worlddb/models'

      ## also add to xxxx ???
      ## (possible to include as globals ???? how - Object.send :include ???) or
      ##   Module.send :include ??
      ## find a better check - check for constants defined??? if not define???
      ##  or use constant_missing handler???

    if res == false
      puts "  todo/fix: WorldDb::Models already included ??"
    end
    
    puts "include WorldDb::Models"

    ### check/fix: include as globals/top-level!!! how? possible???
    Builder.send      :include, WorldDb::Models
    PageCtx.send      :include, WorldDb::Models
    HybookHelper.send :include, WorldDb::Models ## constants not accesible (include in module too)
    ## BookCtx.send :include, WorldDb::Models   -- needed for Book context too?? why, why not??
  end # method prepare
end  # class WorldDef


class BeerDef < Database   ## change to BeerDatabase or DatabaseBeer - why, why not???
  def initialize( db_config )  ## check - if it works by default (no initialze specfied)
    super
  end

  def prepare   ## change to require - why, why not??
    puts "setup beer: #{@db_config.inspect}"

    res = require 'beerdb/models'

    ## also add to xxxx ???
    ## (possible to include as globals ???? how - Object.send :include ???) or
    ##   Module.send :include ??

    if res == false
      ## find a better check - check for constants defined??? if not define???
      ##  or use constant_missing handler???
      puts "  todo/fix: BeerDb::Models already included ??"
    end

    ## for now always include
    puts "  include BeerDb::Models"

    ### check/fix: include as globals/top-level!!! how? possible???
    Builder.send      :include, BeerDb::Models
    PageCtx.send      :include, BeerDb::Models
    HybookHelper.send :include, BeerDb::Models ## constants not accesible (include in module too)


  end # method prepare
end  # class BeerDef


end # module Bookfile
