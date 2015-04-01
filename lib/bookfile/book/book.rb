# encoding: utf-8

###
## todo/fix:
##    render - auto-include/merge (global) book opts ???
##    build book twice (std, and inline:true)
##
##  use global inline? helper instead of passing along
##    opts[:inline] == true  ???? - why, why not???


module HybookHelper
   ## note: "quickfix" - find a better way to forward declare (lives in hybook)???
end


module Bookfile


class PageCtx    ## page context for evaluate

  include HybookHelper

  attr_reader :content

  def initialize( config )   ## BookConfig
    @config  = config
    @content = ''    ## rename to body,text,buf,out - why, why not???
    
    ## track rendering (stack) level - only output if in top-level (1)
    ##  -- check/todo - is there a better way???
    ##  use a (separate) partial method  or keep using on render method etc. ???
    ##   any other ways??
    @level = 0
  end


  def write( text )
    puts "*** write:"
    ## puts "  #{text}"
    
    @content << text
  end

  def render( name, opts={}, locals={} )  ## possible? - make opts required ??
    @level +=1
    puts "*** render(#{@level})  #{name}:"

    tmpl  = File.read_utf8( "#{@config.templates_dir}/#{name}.md" )  ## name e.g. includes/_city

    ### if any locals defined; add "header/preamble w/ shortcuts" to template
    #     e.g. country = locals[:country] etc.
    unless locals.empty?
      tmpl = _locals_code( locals ) + tmpl
    end

    text  = TextUtils::PageTemplate.new( tmpl ).render( binding )

    ## note: only add text to content if top-level render call
    ##   (do NOT add for partials/includes/etc.) 
    if @level == 1
      @content << text
    end

    @level -=1

    ## puts "  #{text}"
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

  def initialize( config, book_opts={} )
    @config  = config
    ## todo: add opts to config ???
    ##  e.g. title, layout, inline ??? - why? why not??
    @builder = BookBuilder.new( config.pages_dir, book_opts )
  end

  ## change name to path - why, why not??
  def page( name, page_opts={} )  ## &block
    puts "[BookCtx#page] #{name} opts:#{page_opts.inspect}"

    puts "[BookCtx#page] before yield"
    ctx = PageCtx.new( @config )   ## pass along self (bookctx) as parent
    yield( ctx )  ## same as - ctx.instance_eval( &block )
    puts "[BookCtx#page] after yield"

    @builder.page( name, page_opts ) do |page|
      page.write ctx.content
    end
  end

end  # class BootCtx


class BookDef
  def initialize( opts={}, proc )
    @opts = opts
    @proc = proc    ## use name block (why,why not??)
    ## @block = block  ## save block as proc ?? ??
  end

  def build( unzip_dir )
    defaults = {  templates_dir: "#{unzip_dir}/_templates",
                  pages_dir:     "#{unzip_dir}/_pages"  }

    ## note:
    ##   (auto)build two versions:
    ##   1) multi-page version - for (easy) browsing
    ##   2) all-in-one-page version - for (easy)pdf conversion

    multi_page_ctx = BookCtx.new( BookConfig.new( defaults ))
    @proc.call( multi_page_ctx )  ## same as - ctx.instance_eval( &@codeblock ) -- use instance_eval - why, why not??

    one_page_ctx = BookCtx.new( BookConfig.new( defaults ), inline: true )
    @proc.call( one_page_ctx )  ## same as - ctx.instance_eval( &@codeblock ) -- use instance_eval - why, why not??
  end
end  # class BookDef


end # module Bookfile

