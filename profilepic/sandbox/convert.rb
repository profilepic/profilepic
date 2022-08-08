###
#  helper to convert csv datasets to spritesheet.js format
#
#  to run use
#    $ ruby sandbox/convert.rb


require 'cocos'


def dump_with_qualifiers( recs )
  recs.each do |rec|
    id   =  rec['id']
    name =  "#{rec['name']} (#{rec['gender']})"
    puts [id, name].join( ', ' )
  end
end

def dump( recs )
  recs.each do |rec|
    id   =  rec['id']
    name =  rec['name']
    puts [id, name].join( ', ' )
  end
end


name = 'yeoldepunks-24x24'
recs = read_csv( "./lib/profilepic/public/#{name}.csv" )

dump_with_qualifiers( recs )


name = 'doge-24x24'
recs = read_csv( "./lib/profilepic/public/#{name}.csv" )

dump( recs )


name = 'marcs-24x24'
recs = read_csv( "./lib/profilepic/public/#{name}.csv" )

dump( recs )



puts "bye"
