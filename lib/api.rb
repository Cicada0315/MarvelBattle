#All data is going to be grabbed here
class API 
  #To access Marvel API you need to have Key & This is permanat so made as class constant
  PUBLICKEY=publickey
  PRIVATEKEY=privatekey

  def initialize
    @base_endpoint= "https://gateway.marvel.com"
  end
    
  def get_marvel_characters_data
    ts=Time.now.to_i.to_s
    #Digest::MD5 A class for calculating message digests 
    #using the MD5 Message-Digest Algorithm by RSA Data Security, Inc., described in RFC1321.
    url_hash= Digest::MD5.hexdigest("#{ts}#{PRIVATEKEY}#{PUBLICKEY}")
    #It only returns 20 for default but I need all the characters
    offset=0
    #loading all the charcters without ability will takes about 20sec
    while(offset<1500) do
      characters_url=@base_endpoint+"/v1/public/characters?ts=#{ts}&apikey=#{PUBLICKEY}&hash=#{url_hash}&limit=50&offset=#{offset}"
      characters_array=HTTParty.get(characters_url)["data"]["results"]
      self.create_character_objects(characters_array)
      offset+=100
    end
  end

  def create_character_objects(characters_array)
    characters_array.each do |character_hash|
      Marvel_Characters.new(character_hash)
    end
  end
end
