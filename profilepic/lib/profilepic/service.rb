###
# serve-up built-in spritesheet(s) and metadata
FILES = {
  # doge
  'doge-24x24.png' => "#{Shibainus.root}/config/spritesheet.png",
  'doge-24x24.csv' => "#{Shibainus.root}/config/spritesheet.csv",
  # marcs
  'marcs-24x24.png' => "#{Pixelart::Module::Punks.root}/config/marcs-24x24.png",
  'marcs-24x24.csv' => "#{Pixelart::Module::Punks.root}/config/marcs-24x24.csv",
  # saudis
  'saudis-24x24.png' => "#{Pixelart::Module::Punks.root}/config/saudis-24x24.png",
  'saudis-24x24.csv' => "#{Pixelart::Module::Punks.root}/config/saudis-24x24.csv",
  # yeoldepunks
  'yeoldepunks-24x24.png' => "#{Pixelart::Module::Punks.root}/config/yeoldepunks-24x24.png",
  'yeoldepunks-24x24.csv' => "#{Pixelart::Module::Punks.root}/config/yeoldepunks-24x24.csv",
}

SPRITESHEETS = {
  doge:        ['doge-24x24.png', 'doge-24x24.csv'],
  marcs:       ['marcs-24x24.png', 'marcs-24x24.csv'],
  saudis:      ['saudis-24x24.png', 'saudis-24x24.csv'],
  yeoldepunks: ['yeoldepunks-24x24.png', 'yeoldepunks-24x24.csv'],
}



def render_spritesheet( type, image_path, meta_path, zoom: 2 )
buf = String.new('')
buf += <<TXT

  <h1> #{type} Spritesheet </h1>
TXT

## note: map "virtual" to real path
path = FILES[ meta_path ]
recs = read_csv( path )

recs.each do |rec|
  id         =  rec['id']
  name       =  rec['name']
  more_names = (rec['more_names'] || '').split( '|' )

  names = [name]
  names += more_names

  key = name
  if rec.has_key?( 'gender' )
    archetype  = (rec['type'] || rec['category'] || '').downcase.strip == 'archetype'
    if archetype
      ## do nothing for base archetype (e.g. male 1, alien, etc.)
    else
       ## auto-add qualifer e.g. (m) or (f) via gender
       gender = (rec['gender'] || 'm').downcase.strip
       key = "#{name} (#{gender})"
       names = names.map { |name| "#{name} (#{gender})"}
    end
end


  buf << "#{id}   "
  buf << "<span class='sprite' data-name='#{key}'></span>"
  buf << "  "
  buf << names.join( ' | ' )
  buf << "<br>\n"
end


buf += <<TXT
<script>
var sheet = Spritesheet.read( '#{image_path}',
`#{spritesheet( meta_path )}` );
sheet.draw();
</script>
TXT

buf

end



class ProfilepicService < Sinatra::Base


  get '/' do
    erb :index
  end

  get '/marcs' do
    erb :marcs
  end

  get '/saudis' do
    erb :saudis
  end

  get '/doge' do
    erb :doge
  end

  get '/yeoldepunks' do
    erb :yeoldepunks
  end



  get '/spritesheets' do

  erb <<TXT

  <p style="font-size: 80%;">
    <a href="/">« Profile Pic(ture) As A Service</a>
  </p>

   <h1>Spritesheets</h1>


   <% SPRITESHEETS.each do |type, files| %>
    <p>
      <b><a href="/<%= type %>_spritesheet"> <%= type %> Attribute Quick Reference</b></a>


       <span style="font-size: 80%;">
    (Source:
     <% files.each_with_index do |name, i| %>
      <%= i > 0 ? ' ·  ' : '' %>
      <a href="/<%= name %>"><%= name %></a>
     <% end %>
       )
       </span>
       </p>
   <% end %>
TXT
  end



FILES.each do |name, real_path|

  basename = File.basename( name )
  extname  = File.extname( name )
  pp [basename, extname]

  puts "adding get route >/#{name}< serving >#{real_path}<"

  get "/#{name}" do
    puts "   serving >#{name}<..."
    if extname == '.csv'
      ## headers( 'Content-Type' => 'text/plain; charset=utf-8' )
      headers( 'Content-Type' => 'text/plain; charset=utf-8' )
      headers( 'Content-Disposition' => 'inline' )
      ## note - do NOT use content type for now
      ##         chrome will DOWNLOAD the file and not display inline
      read_text( real_path )
    else  ## assume png  - image/png
      headers( 'Content-Type' => 'image/png' )
      ## todo/fix. change to read_blob/bin/binary( real_path )
      Pixelart::Image.read( real_path ).to_blob
    end
  end
end


SPRITESHEETS.each do |type, files|
  get "/#{type}_spritesheet" do
     erb render_spritesheet( type, files[0], files[1], zoom: 2 )
  end
end



##
#  generators
  get '/generate_marcs' do
    r = ImageReq.build_marc( params )

     IMAGES[ r.image_key ] = r.image_blob
     redirect "/more?key=#{r.image_key}"
  end

  get '/generate_saudis' do
    r = ImageReq.build_saudi( params )

     IMAGES[ r.image_key ] = r.image_blob
     redirect "/more?key=#{r.image_key}"
  end

 get '/generate_yeoldepunks' do
   r = ImageReq.build_yeoldepunk( params )

   IMAGES[ r.image_key ] = r.image_blob
   redirect "/more?key=#{r.image_key}"
  end

 get '/generate_doge' do
   r = ImageReq.build_doge( params )

   IMAGES[ r.image_key ] = r.image_blob
   redirect "/more?key=#{r.image_key}"
end


  get '/generate' do
     r = ImageReq.build( params )

    IMAGES[ r.image_key ] = r.image_blob
    # redirect "/#{r.image_key}.png"
    redirect "/more?key=#{r.image_key}"
  end




  get '/more' do

    zoom = (params[:z] || '1').strip.to_i( 10 )

    key = params[:key]
    ## split key in name and id  e.g.
    ##    moonbird1660753325   =>  moonbird / 1660753325
    name, id =   if m = key.match( /^(?<name>[a-z_-]+)
                                     (?<id>[0-9]+)$
                                     /ix )
                   [m[:name],m[:id]]
                 else
                   ['?','?']
                 end

    ## change/rename pic to src (or image_src or such - why? why not?)
    pic = "#{key}"
    pic += "@#{zoom}x"   if [2,3,4,5,6,7,8,9,10,20].include?( zoom )
    pic += ".png"

    bg = (params[:bg] || 'none').strip.downcase

    pic += "?bg=#{bg}"   if bg != 'none'


    erb :more, locals: { pic: pic,
                         zoom: zoom,
                         bg: bg,
                         key: key,
                         name: name,
                         id: id }
  end


  get  %r{/(?<key>[a-z0-9]+)
             (@(?<zoom>[0-9]+)x)?
             \.png}xi   do

   # get '/:key(@:zoom)?.png' do
    puts "  .png image request for key: >#{params[:key]}<"
    puts "        with zoom: >#{params[:zoom]}< : #{params[:zoom].class.name}"

    blob = IMAGES[ params[:key] ]


    if blob
      img = Pixelart::Image.blob( blob )

      bg = (params[:bg] || 'none').strip.downcase
      img = img.background( bg )   if bg != 'none'

      zoom = (params[:zoom] || '1').strip.to_i( 10 )
      img = img.zoom( zoom )  if [2,3,4,5,6,7,8,9,10,20].include?( zoom )

      headers( 'Content-Type' => "image/png" )
      img.to_blob
    else
        "404 not found; sorry no generated .png image found for key >#{params[:key]}<"
    end
  end

  get '/cache' do

html =<<HTML
<pre>
   #{IMAGES.size} image(s) in cache:


</pre>
HTML
    html
  end
end    # class ProfilepicService
