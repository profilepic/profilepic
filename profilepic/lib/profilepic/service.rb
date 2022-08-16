

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

    img = r.image

   blob = img.image.to_blob
   IMAGES[ r.image_key ] = blob
   redirect "/#{r.image_key}.png"
 end

 get '/generate_yeoldepunks' do

  r = ImageReq.build_yeoldepunk( params )

  img = r.image

  blob = img.image.to_blob
  IMAGES[ r.image_key ] = blob
  redirect "/#{r.image_key}.png"
 end


 get '/generate_doge' do

  r = ImageReq.build_doge( params )

  img = r.image

 blob = img.image.to_blob
 IMAGES[ r.image_key ] = blob

  ##redirect "/#{r.image_key}.png"
  redirect "/more?key=#{r.image_key}"
end


  get '/generate' do

     r = ImageReq.build( params )

     img = r.image

    blob = img.image.to_blob
    IMAGES[ r.image_key ] = blob

    # redirect "/#{r.image_key}.png"
    redirect "/more?key=#{r.image_key}"
  end




  get '/more' do

    zoom = (params[:z] || '1').strip.to_i( 10 )

    ## change/rename pic to src (or image_src or such - why? why not?)
    pic = "#{params[:key]}"
    pic += "@#{zoom}x"   if [2,3,4,5,6,7,8,9,10,20].include?( zoom )
    pic += ".png"

    bg = (params[:bg] || 'none').strip.downcase

    pic += "?bg=#{bg}"   if bg != 'none'


    erb :more, locals: { pic: pic,
                         zoom: zoom,
                         bg: bg }
  end


  get  %r{/(?<key>[a-z0-9]+)
             (@(?<zoom>[0-9]+)x)?
             \.png}xi   do

   # get '/:key(@:zoom)?.png' do
    puts "  .png image request for key: >#{params[:key]}<"
    puts "        with zoom: >#{params[:zoom]}< : #{params[:zoom].class.name}"

    blob = IMAGES[ params[:key] ]


    if blob
      img_inner = ChunkyPNG::Image.from_blob( blob )
      img = Pixelart::Image.new( img_inner.width, img_inner.height, img_inner )

      bg = (params[:bg] || 'none').strip.downcase
      img = img.background( bg )   if bg != 'none'

      zoom = (params[:zoom] || '1').strip.to_i( 10 )
      img = img.zoom( zoom )  if [2,3,4,5,6,7,8,9,10,20].include?( zoom )

      headers( 'Content-Type' => "image/png" )
      img.image.to_blob
    else
        "404 not found; sorry no generated .png image found for key >#{params[:key]}<"
    end
  end
end


