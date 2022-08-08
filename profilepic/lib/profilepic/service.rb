
###
# helpers
#  to generate

def radio_options_w_sprites( options,
                      name:,
                      legend: )

  buf = <<TXT
<fieldset>
    <legend>#{legend}:</legend>
TXT

options.each_with_index do |option,i|

  value = option.downcase

  ## auto-extract qualifiers e.g. (m)ale/(f)emale
  qualifiers = if    value.index( '(m)' )   then ['m']
               elsif value.index( '(f)' )   then ['f']
               elsif value.index( '(m/f)' ) then ['m', 'f']
               else  []
               end

  value = value.sub( '(m)', '' ).sub( '(f)', '' ).sub( '(m/f)', '' ).sub( '¹', '' )
  value = value.strip



  label = option

buf += <<TXT
<div>
  <input type="radio" id="#{name}#{i}" name="#{name}" value="#{value}"
            #{ i==0 ? 'checked' : '' }>
TXT

if ['none'].include?( value )
   ## do nothing  - no sprite(s) - for none & friends
elsif qualifiers.empty?
  buf +=  %Q[    <span class="sprite" data-name="#{value}"></span>\n]
else
  qualifiers.each do |qualifier|
    buf +=  %Q[    <span class="sprite" data-name="#{value} (#{qualifier})"></span>\n]
  end
end

buf += <<TXT
       <label for="#{name}#{i}">#{label}</label>
</div>
TXT
end


buf += "</fieldset>\n"
buf

end


def radio_options( options,
                     name:,
                     legend: )

  buf = <<TXT
<fieldset>
    <legend>#{legend}:</legend>
TXT

options.each_with_index do |option,i|

  value = option.downcase
  value = value.sub( '(m)', '' ).sub( '(f)', '' ).sub( '(m/f)', '' ).sub( '¹', '' )
  value = value.strip

  label = option

buf += <<TXT
<div>
  <input type="radio" id="#{name}#{i}" name="#{name}" value="#{value}"
            #{ i==0 ? 'checked' : '' }>
       <label for="#{name}#{i}">#{label}</label>
</div>
TXT
end

buf += "</fieldset>\n"
buf
end


YEOLDEPUNK_ARCHETYPE = [
  'Male 1',
  'Male 2',
  'Male 3',
  'Male 4',
  'Female 1',
  'Female 2',
  'Female 3',
  'Female 4',
  'Zombie',
  'Ape',
  'Alien',
]


YEOLDEPUNK_HAIR = [
  'Shaved Head (m)',
  'Peak Spike (m)',
  'Vampire Hair (m)',
  'Purple Hair (m)',

  'Mohawk (m/f)',
  'Mohawk Dark (m/f)',
  'Mohawk Thin (m/f)',
  'Wild Hair (m/f)',
  'Crazy Hair (m/f)',
  'Messy Hair (m/f)',
  'Frumpy Hair (m/f)',
  'Stringy Hair (m/f)',
  'Clown Hair Green (m/f)',

  'Straight Hair (f)',
  'Straight Hair Dark (f)',
  'Straight Hair Blonde (f)',
  'Blonde Short (f)',
  'Blonde Bob (f)',
  'Wild Blonde (f)',
  'Wild White Hair (f)',
  'Orange Side (f)',
  'Dark Hair (f)',
  'Pigtails (f)',
  'Pink With Hat¹ (f)',
  'Half Shaved (f)',
  'Red Mohawk (f)',
]

YEOLDEPUNK_BEARD = [
  'Shadow Beard (m)',
  'Normal Beard (m)',
  'Normal Beard Black (m)',
  'Big Beard (m)',
  'Luxurious Beard (m)',
  'Mustache (m)',
  'Goat (m)',
  'Handlebars (m)',
  'Front Beard (m)',
  'Front Beard Dark (m)',
  'Chinstrap (m)',
  'Muttonchops (m)',
]

YEOLDEPUNK_EYEWEAR = [
  'Small Shades (m)',
  'Regular Shades (m/f)',
  'Classic Shades (m/f)',
  'Big Shades (m/f)',
  'Nerd Glasses (m/f)',
  'Horned Rim Glasses (m/f)',
  '3D Glasses (m/f)',
  'VR (m/f)',
  'Eye Mask (m/f)',
  'Eye Patch (m/f)',
  'Welding Goggles (f)',
]

YEOLDEPUNK_EARRING = [
  'Earring (m/f)'
]


YEOLDEPUNK_HEADWEAR = [
  'Cowboy Hat (m)',
  'Fedora (m)',
  'Hoodie (m)',
  'Beanie (m)',
  'Top Hat (m)',
  'Do-rag (m)',
  'Police Cap (m)',
  'Cap Forward (m)',
  'Cap (m/f)',
  'Knitted Cap (m/f)',
  'Bandana (m/f)',
  'Headband¹ (m/f)',
  'Pilot Helmet (f)',
  'Tassle Hat (f)',
  'Tiara (f)',
]

YEOLDEPUNK_EYES = [
  'Clown Eyes Green (m/f)',
  'Clown Eyes Blue (m/f)',
  'Green Eye Shadow (f)',
  'Blue Eye Shadow (f)',
  'Purple Eye Shadow (f)',
]

YEOLDEPUNK_MOUTH = [
 'Smile (m)',
 'Frown (m)',
 'Buck Teeth (m)',
 'Hot Lipstick (f)',
 'Black Lipstick (f)',
 'Purple Lipstick (f)',
]


YEOLDEPUNK_MOUTH_PROP = [
 'Cigarette (m/f)',
 'Vape (m/f)',
 'Pipe (m/f)',
 'Medical Mask (m/f)',
]

YEOLDEPUNK_NECK = [
  'Silver Chain (m/f)',
  'Gold Chain (m/f)',
  'Choker (f)',
]

YEOLDEPUNK_BLEMISH = [
  'Mole (m/f)',
  'Spots (m/f)',
  'Rosy Cheeks (m/f)',
]

YEOLDEPUNK_NOSE = [
  'Clown Nose (m/f)',
]




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


