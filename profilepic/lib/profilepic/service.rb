
###
# helpers
#  to generate

def radio_options( options,
                     name:,
                     legend: )

  buf = <<TXT
<fieldset>
    <legend>#{legend}:</legend>
TXT

options.each_with_index do |option,i|

  value = option.downcase
  label = option

buf += <<TXT
<div>
  <input type="radio" id="#{name}#{i}" name="#{name}" value="#{value}"
            #{ i==0 ? 'checked' : '' }
       <label for="#{name}#{i}">#{label}</label>
</div>
TXT
end

buf += "</fieldset>\n"
buf
end


DOGE_ARCHETYPE = [
  'Classic',
  'Dark',
  'Zombie',
  'Alien',
]

DOGE_HAIR = [
 'Crazy Hair',
]

DOGE_HEADWEAR = [
  'Beanie',
  'Cap',
  'Cap Forward',
  'Cowboy Hat',
  'Fedora',
  'Knitted Cap',
  'Top Hat',
  'Bandana',
  'Headband',
  'Tiara',
]

DOGE_EYEWEAR = [
  '3D Glasses',
  'Big Shades',
  'Classic Shades',
  'Regular Shades',
  'Small Shades',
  'Nerd Glasses',
  'Eye Patch',
]



MARC_ARCHETYPE = [
 'Marc',
 'Marc Mid',
 'Marc Dark',
 'Marc Albino',
 'Marc Golden',
 'Mad Lad',
 'Zombie',
 'Ape',
 'Ape Golden',
 'Ape Pink',
 'Alien',
 'Alien Green',
 'Devil',
 'Orc',
 'Skeleton',
 'Bot']


MARC_EYES = [
  'Blue Eyes',
  'Green Eyes',
]

MARC_FACE = [
  'Blue Eye Shadow',
  'Green Eye Shadow',
  'Purple Eye Shadow',
  'Clown Eyes Blue',
  'Clown Eyes Green',
  'Bagner',
  'Marc Tyson',
  'Tears',
]

MARC_BEARD = [
  'Big Beard White',
  'Big Beard',
  'Chinstrap',
  'Front Beard',
  'Front Beard Dark',
  'Full Mustache',
  'Full Mustache Dark',
  'Goat',
  'Goat Dark',
  'Handlebar',
  'Luxurious Beard',
  'Mustache',
  'Mutton Chop',
  'Normal Beard',
  'Normal Beard Black',
  'Shadow Beard',
  'Soul Patch',
]

MARC_HAIR = [
  'Blonde Bob',
  'Chad',
  'Clown Hair',
  'Crazy White Hair',
  'Crazy Hair',
  'Frumpy Hair',
  'Marc Three',
  'Purple Hair',
  'Stringy Hair',
  'Vampire Hair',
  'Wild Blonde Hair',
  'Wild Hair',
]

MARC_HEADWEAR = [
  'Bandana',
  'Beanie',
  'Bunny Ears',
  'Cap',
  'Skull Cap',
  'Cap Forward',
  'Police Cap',
  'Cowboy Hat',
  'Do Rag',
  'Fast Food',
  'Marcdonalds',
  'Fedora',
  'Headband',
  'Roaring Headband',
  'Hoodie',
  'Purple Hoodie',
  'Knitted Cap',
  'Laurels',
  'Shemagh',
  'Tassle Hat',
  'Tiarra',
  'Top Hat',
  'Uncle Sam',
  'Viking',
  'Welding Goggles',
]


MARC_EYEWEAR = [
  '3D Glasses',
  'Aviators',
  'Big Shades',
  'Classic Shades',
  'Deal With It',
  'Glasses',
  'Gold Glasses',
  'Horned-Rim Glasses',
  'Monocle',
  'Nerd Glasses',
  'Pink Shades',
  'Polarized',
  'Polarized White',
  'Regular Shades',
  'Small Shades',
  'VR Headset',
  'Eye Mask',
  'Eye Patch',
  'Lasers']

MARC_MOUTH_PROP = [
  'Cigar',
  'Cigarette',
  'Hookah',
  'Pipe',
  'Vape',
  'Medical Mask',
  'Bubble Gum' ]




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


  get '/generate_marcs' do

    r = ImageReq.build_marc( params )

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
 redirect "/#{r.image_key}.png"
end


  get '/generate' do

     r = ImageReq.build( params )

     img = r.image

    blob = img.image.to_blob
    IMAGES[ r.image_key ] = blob
    redirect "/#{r.image_key}.png"
  end


  get '/:key.png' do
    puts "  .png image request for key: >#{params[:key]}<"

    blob = IMAGES[ params[:key] ]

    if blob
      headers( 'Content-Type' => "image/png" )
      blob
    else
        "404 not found; sorry no generated .png image found for key >#{params[:key]}<"
    end
  end
end


