# encoding: utf-8

module Bookfile

module PageHelper
  ## auto-load helpers here
  def render_toc
    "render_toc"
  end
 
  def render_country( country )
    "render_country #{country.name}"
  end
end


class BookConfig
  def initialize( hash={} )
    @hash = hash
  end
  
  def templates_dir
    @hash[:templates_dir]
  end
end



class PageCtx    ## page context for evaluate
  ## TEMPLATES_DIR = ??
  include PageHelper

  def initialize( config )
    ## pass in templates_dir here#
    ##  or pass in class to help find templates???
    ##  TemplateMan( ??? )
    @config = config
  end

  def write( text )
    puts "*** write:"
    puts "  #{text}"
  end

  def render( name, opts={} )
     tmpl  = File.read_utf8( "#{@config.templates_dir}/#{name}.md" )  ## name e.g. includes/_city
     TextUtils::PageTemplate.new( tmpl ).render( binding )
  end

  ## add render here
  ##   ## fix: use TemplateReader/Finder/Man ???
  ##  tmpl       = File.read_utf8( "#{TEMPLATES_DIR}/includes/_city.md" )
  ##  TextUtils::PageTemplate.new( tmpl ).render( binding )
end  # class PageCtx


class BookCtx

  def initialize( config )
    @config = config
  end

  def page( name, opts={} )  ## &block
    puts "[BookCtx#page] #{name} opts:#{opts.inspect}"
    
    puts "[BookCtx#page] before yield"
    ctx = PageCtx.new( @config )   ## pass along book configs
    yield( ctx )  ## same as - ctx.instance_eval( &block )
    puts "[BookCtx#page] after yield"
  end

end  # class BootCtx


class BookDef
  def initialize( opts={}, proc )
    @opts = opts
    @proc = proc    ## use name block (why,why not??)
    ## @block = block  ## save block as proc ?? ??
  end

  def build
    config = BookConfig.new( templates_dir: './templates' )
    ctx = BookCtx.new( config )
    @proc.call( ctx )  ## same as - ctx.instance_eval( &@codeblock ) -- use instance_eval - why, why not??
  end
end  # class BookDef


end # module Bookfile

