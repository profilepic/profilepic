# encoding: utf-8

package 'book-templates/football'


football adapter: 'sqlite3', database: './football.db'



book do |b|

  opts = {}

  ### generate table of contents (toc)

  b.page( 'index', title: 'Contents',
                   id:    'index' ) do |page|
      page.render_cover( opts )
      page.render_about( opts )
      page.render_toc( opts )
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
         page.render_event( event, opts )
       end
       ## b.divider()  ## -- todo: add for inline version
       event_count += 1
    end
  end

  ## ### generate events index
  ##  b.page( 'events', title: 'Events',
  ##                    id:    'events' ) do |page|
  ##    page.render_events( opts )
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
        page.render_country( country, opts )
      end

      country_count += 1
    end
  end


  b.page( 'stadiums', title: 'Stadiums',
                      id:    'stadiums' ) do |page|
    page.render_grounds( opts )
  end


  ### generate national teams a-z index
  b.page( 'national-teams', title: 'National Teams A-Z Index',
                            id:    'national-teams' ) do |page|
    page.render_national_teams_idx( opts )
  end

  ### generate teams a-z index
  b.page( 'clubs', title: 'Clubs A-Z Index',
                   id:    'clubs' ) do |page|
    page.render_clubs_idx( opts )
  end

  b.page( 'back', title: 'Back',
                  id:    'back' ) do |page|
    page.render_back( opts )
  end

end # block book

