class ProfilepicService < Sinatra::Base

  get '/' do
    erb :index
  end


  get '/generate' do
     type       = params[:t]          || "punk"
     attributes = params[:attributes] || ""
     zoom       = params[:z]          || "1"
     background = params[:bg]         || "none"

     txt= <<TXT
  image generation (string) params:
     type:        >#{type}<  - #{type.class.name}
     attributes:  >#{attributes}< - #{attributes.class.name}
     zoom:        >#{zoom}<   - #{zoom.class.name}
     background   >#{background}<   - #{background.class.name}
TXT

    # convert attributes to array
    ##   allow various separators
    attributes = attributes.split( %r{[,;|+/]+} )
    attributes = attributes.map { |attr| attr.strip }
    attributes = attributes.select { |attr| !attr.empty?}   ## remove empty strings (if any)

    type       = type.downcase.strip
    zoom       = zoom.strip.to_i( 10 )
    background = background.downcase.strip

    txt += <<TXT
  resulting in:
       type:  >#{type}<  - #{type.class.name}
       #{attributes.size} attribute(s):
        #{attributes.join(', ')}
       zoom @ #{zoom}x - #{zoom.class.name}
       background   >#{background}<   - #{background.class.name}
TXT

     puts "generate request:"
     puts txt

    img = Original::Image.fabricate( type, *attributes )
    img = img.background( background )   if background != 'none'
    img = img.zoom( zoom )  if [2,3,4,5,6,7,8,9,10,20].include?( zoom )

    #  check - add a debug/save option - why? why not?
    # img.save( "./tmp/profilepic-#{Time.now.to_i}.png" )

    headers( 'Content-Type' => "image/png" )

    blob = img.image.to_blob
    blob
  end
end


