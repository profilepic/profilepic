# encoding: utf-8


module Bookfile

class BookPackage     ## change to BookTemplates/BookTheme/BookPack/BookClass/BookStyle ???
  def initialize( name, opts={} )
    @name = name
    @opts = opts
  end


  def remote_zip_url  # remote zip url
    ###  note: use http:// for now - lets us use (personal proxy NOT working w/ https) for now
    ## "https://github.com/#{@name}/archive/gh-pages.zip"
    "http://github.com/#{@name}/archive/gh-pages.zip"
  end

  def local_zip_name
    ### note: replace / in name w/ --I--
    ##  e.g. flatten the filename, that is, do NOT include any folders
    @name.gsub('/', '--I--')   # note: will NOT include/return .zip extension
  end

  def local_zip_dir
    "./tmp"
  end

  def local_zip_path  # local zip path
    "#{local_zip_dir}/#{local_zip_name}.zip"
  end

  def local_unzip_dir
    "./book"
  end

  def local_scripts_dir
    ## fix: just use _scripts  -- remove helpers in repo!!!
    "#{local_unzip_dir}/_scripts/helpers"
  end


  def download
    ## logger.info( "download book package '#{@name}'" )
    ## logger.info( "   from '#{remote_zip_url}'" )
    ## logger.info( "   to '#{local_zip_path}'..." )

    ## note: lets use http:// instead of https:// for now - lets us use person proxy (NOT working w/ https for now)
    src      = remote_zip_url
    dest_zip = local_zip_path

    ## make sure dest folder exists
    FileUtils.mkdir_p( local_zip_dir )  unless Dir.exists?( local_zip_dir )

    fetch_book_templates( src, dest_zip )
  end


  def unzip
    src        = local_zip_path
    dest_unzip = local_unzip_dir

    ## check if folders exists? if not create folder in path
    FileUtils.mkdir_p( dest_unzip )  unless Dir.exists?( dest_unzip )

    unzip_book_templates( src, dest_unzip )
  end


  def prepare   ## change to require - why, why not??
    puts "auto-require/include book scripts in '#{local_scripts_dir}'"

    files = Dir["#{local_scripts_dir}/**/*.rb"]
    pp files

    files.each_with_index do |file,idx|
       ## todo/check: check for exceptions???
       puts "  [#{idx+1}/#{files.count}] try auto-require '#{file}'..."
       require file
    end

     ## include Hytext::Helper or use HytextHelper  ??
     ## include Bookfile::Helper or use BookfileHelper ??
     ##   check Rails example names for helper modules
     ##   get Helper module name from book template name ???

=begin
    res = require 'worlddb/models'
    if res
      puts "  include WorldDb::Models"
      
      Builder.send :include, WorldDb::Models
      ## PageCtx.send :include, WorldDb::Models
      ## BookCtx.send :include, WorldDb::Models
      
      ## also add to xxxx ???
      ## (possible to include as globals ???? how - Object.send :include ???) or
      ##   Module.send :include ??
    else
      ## find a better check - check for constants defined??? if not define???
      ##  or use constant_missing handler???
      puts "  assume WorldDb::Models already included ??"
    end
=end
  end


private

def fetch_book_templates( src, dest )
  ## step 1 - fetch archive
  worker = Fetcher::Worker.new
  worker.copy( src, dest )
  ### fix: add  src.sha5
  ###      inside folder
  ### lets us check if current HEAD version is in place across datafiles etc.
  ##  - try HTTP HEAD ?? to check?
end


def unzip_book_templates( src, dest, opts={} )
  ### todo/fix: rename or remove root folder -- use opts { root: false or something??}
  #  e.g
  #  !/beer-gh-pages/_templates/ becomes
  #  !/_templates/   etc.

  Zip::File.open( src ) do |zipfile|
    zipfile.each do |file|
      if file.directory?
        puts "  skip directory zip entry - #{file.name}"
      else
        name = file.name[ file.name.index('/')+1..-1]   ## cut-off root/first path entry
        path = File.join( dest, name)
        puts "  unzip file zip entry - #{file.name} to #{path}"
        FileUtils.mkdir_p( File.dirname( path) )
        zipfile.extract(file, path)  unless File.exist?(path)
      end
    end
  end
end

end # class BookPackage

end # module Bookfile

