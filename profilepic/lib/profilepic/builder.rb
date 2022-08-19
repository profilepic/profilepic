
## keep cache of generated images (profile pics)
IMAGES = {}




class ImageReq    ## (Generate) Image Request
  def self.build( params )
    puts "==> image request params:"
    pp params

     name       = _norm_key( params[:t] || 'punk'  )
     attributes = _parse_attributes( params[:attributes] || '' )

      new( name: name,
           attributes: attributes )
  end

  def self.build_marc( params )
    puts "==> image request params:"
    pp params

      name = 'marc'
      attributes = _build_attributes( params, MARC )

      new( name: name,
           attributes:  attributes )
  end


  def self.build_saudi( params )
    puts "==> image request params:"
    pp params

      name = 'saudi'
      attributes = _build_attributes( params, SAUDI )

      new( name: name,
           attributes:  attributes )
  end


  def self.build_doge( params )
    puts "==> image request params:"
    pp params

      name = 'doge'

      attributes = _build_attributes( params, DOGE )

      new( name: name,
           attributes:  attributes )
  end


  def self.build_yeoldepunk( params )
    puts "==> image request params:"
    pp params

      name = 'yeoldepunk'

      attributes = _build_attributes( params, YEOLDEPUNK )

      new( name: name,
           attributes:  attributes )
  end



  attr_reader :name,
              :attributes
  def initialize( name:, attributes: )
     @name       = name
     @attributes = attributes
  end

  def image
    ## check - cache / memoize image - why? why not?
    Original::Image.fabricate( @name, *@attributes )
  end

  def image_blob() image.to_blob;  end
  alias_method :blob, :image_blob   ## keep (shortcut) alias - why? why not?

  def image_key
     @key ||= "#{@name}#{Time.now.to_i}"
     @key
  end
  alias_method :key, :image_key    ## keep (shortcut) alias - why? why not?



#####
#  (static) helpers

def self._norm_key( str )
  str.downcase.strip
end

def self._build_attributes( params, spec )
  attributes = []
  spec.each do |name,h|

    value = params[name]

    if value.nil? || value.empty?
      required =  h[:none] == true   ## check if value is required or optional
      if required
         raise ArgumentError, "required attribute/param >#{name}< missing"
      else
         next   ## skip optional attributes
      end
    else
        key = _norm_key( value )
        attributes << key       if key != 'none'
    end
  end
  attributes
end


def self._parse_attributes( str )
  # convert attributes to array
  ##   allow various separators
  attributes = str.split( %r{[,;|+/]+} )
  attributes = attributes.map { |attr| attr.strip }
  attributes = attributes.select { |attr| !attr.empty?}   ## remove empty strings (if any)
  attributes
end

end   # class ImageReq - (Generate) Image Request

