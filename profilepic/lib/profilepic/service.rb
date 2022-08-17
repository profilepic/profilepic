

class ProfilepicService < Sinatra::Base

  get '/cache' do

html =<<HTML
<pre>
   #{IMAGES.size} image(s) in cache:


</pre>
HTML
    html
  end



  get '/' do
    erb :index
  end

  get '/marcs' do
    erb :marcs
  end

  get '/doge' do
    erb :doge
  end

  get '/yeoldepunks' do
    erb :yeoldepunks
  end




  get '/generate_marcs' do
    r = ImageReq.build_marc( params )

     IMAGES[ r.image_key ] = r.image_blob
     # redirect "/#{r.image_key}.png"
     redirect "/more?key=#{r.image_key}"
  end

 get '/generate_yeoldepunks' do
   r = ImageReq.build_yeoldepunk( params )

   IMAGES[ r.image_key ] = r.image_blob
   # redirect "/#{r.image_key}.png"
   redirect "/more?key=#{r.image_key}"
  end

 get '/generate_doge' do
   r = ImageReq.build_doge( params )

   IMAGES[ r.image_key ] = r.image_blob
   ##redirect "/#{r.image_key}.png"
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
end


