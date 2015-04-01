# encoding: utf-8


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book


## quick fix/hack for settings globals; fix: use config hash etc.
PAGES_DIR     = $pages_dir      if defined?( $pages_dir )
TEMPLATES_DIR = $templates_dir  if defined?( $templates_dir )

puts '[book] Welcome'
puts "[book]   Dir.pwd:       #{Dir.pwd}"
puts "[book]   PAGES_DIR:     #{PAGES_DIR}"
puts "[book]   TEMPLATES_DIR: #{TEMPLATES_DIR}"


# -- model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City

Team      = SportDb::Model::Team
League    = SportDb::Model::League
Event     = SportDb::Model::Event
Game      = SportDb::Model::Game
Ground    = SportDb::Model::Ground

# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/ground'
require_relative 'helpers/team'
require_relative 'helpers/page'


require_relative 'utils'




def build_book( opts={} )

  ### title: '{{ site.title }}',

  b = BookBuilder.new( PAGES_DIR, opts )


  ### generate table of contents (toc)

  b.page( 'index', title: 'Contents',
                   id:    'index' ) do |page|
      page.write render_cover( opts )
      page.write render_about( opts )
      page.write render_toc( opts )
  end


  # note: use same order as table of contents
  event_count = 0
  League.order(:id).each do |league|
    next if league.events.count == 0

    league.events.each do |event|
       puts "  build event page [#{event_count+1}] #{event.key} #{event.title}..."
 
       key = event.key.gsub( '/', '_' )
       b.page( "events/#{key}", title: "#{event.title}",
                                id:    "#{key}" ) do |page|
         page.write render_event( event, opts )
       end
       ## b.divider()  ## -- todo: add for inline version
       event_count += 1
    end
  end

  ## ### generate events index
  ##  b.page( 'events', title: 'Events',
  ##                    id:    'events' ) do |page|
  ##    page.write render_events( opts )
  ##  end


  # note: use same order as table of contents
  country_count = 0
  Continent.order(:id).each do |continent|
    continent.countries.order(:name).each do |country|
      next if country.teams.count == 0   # skip country w/o teams

      puts "  build country page [#{country_count+1}] #{country.key} #{country.title}..."

      path = country.to_path
      puts "    path=#{path}"
      b.page( "teams/#{path}", title: "#{country.title} (#{country.code})",
                               id:    "#{country.key}" ) do |page|
        page.write render_country( country, opts )
      end

      country_count += 1
    end
  end


  b.page( 'stadiums', title: 'Stadiums',
                      id:    'stadiums' ) do |page|
    page.write render_grounds( opts )
  end


  ### generate national teams a-z index
  b.page( 'national-teams', title: 'National Teams A-Z Index',
                            id:    'national-teams' ) do |page|
    page.write render_national_teams_idx( opts )
  end

  ### generate teams a-z index
  b.page( 'clubs', title: 'Clubs A-Z Index',
                   id:    'clubs' ) do |page|
    page.write render_clubs_idx( opts )
  end

  b.page( 'back', title: 'Back',
                  id:    'back' ) do |page|
    page.write render_back( opts )
  end

end # method build_book

