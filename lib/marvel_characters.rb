#marvel_characters Object
class Marvel_Characters
  attr_accessor :abilities
  @@all =[]
  def initialize(character_hash)
    character_hash.each do  |key, value|
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end 
end