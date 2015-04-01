# encoding: utf-8


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/beer'
require_relative 'helpers/brewery'
require_relative 'helpers/city'
require_relative 'helpers/page'


require_relative 'utils'

## quick fix/hack for settings globals; fix: use config hash etc.
PAGES_DIR     = $pages_dir      if defined?( $pages_dir )
TEMPLATES_DIR = $templates_dir  if defined?( $templates_dir )


puts '[book] Welcome'
puts "[book]   Dir.pwd:       #{Dir.pwd}"
puts "[book]   PAGES_DIR:     #{PAGES_DIR}"
puts "[book]   TEMPLATES_DIR: #{TEMPLATES_DIR}"


### model shortcuts

require_relative 'models'


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book



def build_book_for_country( country_code, opts={} )

  country = Country.find_by_key!( country_code )

  b = BookBuilder.new( PAGES_DIR, opts )

### generate breweries index

  b.page( "#{country.key}-breweries", title: 'Breweries Index',
                                      id: "/#{country.key}-breweries" ) do |page|
    page.write render_breweries_idx( opts )
  end

  ### generate pages for countries
  
  puts "build country page #{country.key}..."

  path = country.to_path
  puts "path=#{path}"
  b.page( path,   title: "#{country.title} (#{country.code})",
                  id:    "#{country.key}" ) do |page|
    page.write render_country( country, opts )
  end

  b.page( "#{country.key}-mini", title: "#{country.title} (#{country.code}) - Mini",
                                 id:    "#{country.key}-mini" ) do |page|
    page.write render_country_mini( country, opts )
  end

  b.page( "#{country.key}-stats", title: "#{country.title} (#{country.code}) - Stats",
                                  id:    "#{country.key}-stats.html" ) do |page|
    page.write render_country_stats( country, opts )
  end

end



def build_book( opts={} )

b = BookBuilder.new( PAGES_DIR, opts )

### generate what's news in 2014

years = [2014,2013,2012,2011,2010]
years.each do |year|
  b.page( "#{year}", title:  "What's News in #{year}?",
                     id: "#{year}" ) do |page|
    page.write render_whats_news_in_year( year, opts )
  end
end


### generate breweries index

b.page( 'breweries', title: 'Breweries Index',
                     id: 'breweries' ) do |page|
  page.write render_breweries_idx( opts )
end


### generate beers index

b.page( 'beers', title: 'Beers Index',
                 id: 'beers' ) do |page|
  page.write render_beers_idx( opts )
end


### generate brands index

b.page( 'brands', title: 'Brands Index',
                  id: 'brands' ) do |page|
  page.write render_brands_idx( opts )
end


### generate table of contents (toc)

b.page( 'index', title: 'Contents',
                 id: 'index' ) do |page|
  page.write render_toc( opts )
end



### generate pages for countries

country_count=0
# Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
Country.order(:id).each do |country|
  beers_count     = country.beers.count
  breweries_count = country.breweries.count
  next if beers_count == 0 && breweries_count == 0
  
  country_count += 1
  puts "build country page #{country.key}..."

  path = country.to_path
  puts "path=#{path}"
  b.page( path, title: "#{country.title} (#{country.code})",
                id:    "#{country.key}" ) do |page|
    page.write render_country( country, opts )
  end

  ## todo - add  b.divider() - for inline version - why, why not ????

  ## break if country_count == 3    # note: for testing only build three country pages
end

end # method build_book

