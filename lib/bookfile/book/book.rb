# encoding: utf-8

###
## todo/fix:
##    render - auto-include/merge (global) book opts ???
##    build book twice (std, and inline:true)
##
##  use global inline? helper instead of passing along
##    opts[:inline] == true  ???? - why, why not???


module Bookfile


class PageCtx    ## page context for evaluate

  include HybookHelper

  def initialize( config )   ## BookConfig
    ## pass in templates_dir here
    ##   ## TEMPLATES_DIR = ??  -- passed in as config
    ##  or pass in class to help find templates???
    ##  TemplateMan( ??? )
    @config = config
  end

  def write( text )
    puts "*** write:"
    puts "  #{text}"
  end

  def render( name, opts={}, locals={} )  ## possible? - make opts required ??
    puts "*** render #{name}:"

    tmpl  = File.read_utf8( "#{@config.templates_dir}/#{name}.md" )  ## name e.g. includes/_city

    ### if any locals defined; add "header/preamble w/ shortcuts" to template
    #     e.g. country = locals[:country] etc.
    unless locals.empty?
      tmpl = _locals_code( locals ) + tmpl
    end

    text  = TextUtils::PageTemplate.new( tmpl ).render( binding )

    puts "  #{text}"
    text
  end


  def _locals_code( locals )
    ## convert locals hash to erb snippet with shortcuts
    ##    e.g.  country = locals[:country]
    ## and so on

    buf = "<%\n"
    locals.each do |k,v|
      puts "  add local '#{k}' #{k.class.name} - #{v.class.name}"

      buf << "#{k} = locals[:#{k}];\n"
    end
    buf << "%>\n"
    buf
  end

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

  def build( unzip_dir )
    config = BookConfig.new( templates_dir: "#{unzip_dir}/_templates" )
    ctx = BookCtx.new( config )
    @proc.call( ctx )  ## same as - ctx.instance_eval( &@codeblock ) -- use instance_eval - why, why not??
  end
end  # class BookDef


end # module Bookfile

