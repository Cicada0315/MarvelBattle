class CLI
  def initialize
    API.new.get_marvel_characters_data
  end

  def run
    greeting
    option
  end

  def greeting
    puts "Welcome to MarvelBattle"
    puts "We always fight for justice!\n"
  end

  def option
    #Marvel_Characters.all.each.with_index(1) {|character, index| puts "#{index}. #{character.name}"}
    i=0
    while i< Marvel_Characters.all.size
      20.times do 
        character=Marvel_Characters.all[i]
        puts "#{i+1}. #{character.name}"
        i+=1
      end
      puts "Enter 1: To see next characters"
      puts "Enter 2: Select characters"
      puts "Enter 3: Character information"
      puts "Enter 4: To end the program"

      input=gets.to_i
      case input 
      when 1
        next
      when 2
        select_characters
      when 3
        character_information
      when 4
        exit
      end
    end
  end

  def select_characters
    puts "Choose your characters(choose three characters)"
    my_characters=[]
    inputs=[]
   
    while my_characters.size<3
      input=gets
      if inputs.include?(input)
        puts "You already choose that character, try another one"
      else
        inputs<<input
        my_characters << Marvel_Characters.all[input.to_i-1]
      end
    end
    my_characters.each {|character| print character.name+" "}
    puts "\nEnter 1: Incorrect"
    puts "Enter 2: Correct, Ready to play"
    input = gets.to_i
    case input
      when 1
        select_characters
      when 2
        computer_characters=select_computer_characters
        begin
          add_abilities(my_characters)
          add_abilities(computer_characters)
          play(my_characters, computer_characters)
        rescue => exception
          puts "There are too many request to the website right now. Try again later."
          option
        end
      end
  end 

  def select_computer_characters
    computer_characters=[]
    while computer_characters.size<3
      ramdon_character=rand(0..Marvel_Characters.all.size)
      computer_characters << Marvel_Characters.all[ramdon_character]
    end
    computer_characters
  end

  def add_abilities(arr)
    arr.collect do |character|
      character.abilities=get_abilities(character.urls[0]["url"]) if character.abilities==nil
    end
  end

  def get_abilities(abilities_url)
    html = open(abilities_url, :allow_redirections => :all)
    doc=Nokogiri::HTML(html)
    abilities_hash={}
    rates=[]
    doc.css(".power-circle__rating").each {|rate| rates<<rate.text.to_i}
    rate_index=0
    
    doc.css(".power-circle__label").each do |ability|
      abilities_hash["#{ability.text}"] = "#{rates[rate_index]}"  
      rate_index+=1
    end 
    #use this as default since some of them doesn't have rates
    if abilities_hash.empty?
      abilities_hash["durability"]="2"
      abilities_hash["energy"]="2"
      abilities_hash["fighting skills"]="2"
      abilities_hash["intelligence"]="2"
      abilities_hash["speed"]="2"
      abilities_hash["strength"]="2"
    end
    abilities_hash
    #binding.pry
  end

  def character_information
    puts "Choose your character"
    character_num=gets
    puts Marvel_Characters.all[character_num.to_i-1].name
    puts "Enter 1: Incorrect"
    puts "Enter 2: Correct"
    input = gets.to_i
    case input
    when 1
      character_information
    when 2
      select_info(character_num)
    end
  end
  
  def select_info(index)
    puts "which information would you want to see?"
    puts "Enter 1: Image of character"
    puts "Enter 2: Abilities"
    puts "Enter 3: Comics"
    puts "Enter 4: Series"
    puts "Enter 5: Description"

    input = gets.to_i
    case input
    when 1
      image_url=Marvel_Characters.all[index.to_i-1].thumbnail["path"]
      image_url+=".jpg"
      begin
        Launchy.open(image_url)
      rescue => exception
        puts "You might be on wsl. If you cannot see the browser, use url down below"
        puts image_url
      end  
      
    when 2
      Marvel_Characters.all[index.to_i-1].abilities = get_abilities(Marvel_Characters.all[index.to_i-1].urls[0]["url"]) if Marvel_Characters.all[index.to_i-1].abilities==nil
      puts Marvel_Characters.all[index.to_i-1].abilities
    when 3
      puts "Available comics: #{Marvel_Characters.all[index.to_i-1].comics["available"]}"
      Marvel_Characters.all[index.to_i-1].comics["items"].each {|item| puts item["name"]}
    when 4
      "Available Series: #{Marvel_Characters.all[index.to_i-1].series["available"]}"
      Marvel_Characters.all[index.to_i-1].series["items"].each {|item| puts item["name"]}
    when 5
      description=Marvel_Characters.all[index.to_i-1].description 
      if description.length>0
        puts description
      else 
        puts "No description provided"
      end
    end

    puts "Enter 1: Select_information (same character)"
    puts "Enter 2: Character_information (Other character)"
    puts "Enter 3: Select_characters"
    puts "Enter 4: To end the program"
    input = gets.to_i
    case input
    when 1
      select_info(index)
    when 2
      character_information
    when 3
      select_characters
    when 4
      exit
    end
  end

  def play(human_character, computer_character)
    puts "Enter your name"
    name=gets
    player=Human.new(name, human_character)
    computer=Computer.new(computer_character)
    battle=Marvel_Battle.new(player, computer)
    battle.display_ring
    while true do
      puts "Enter 1: Match1"
      puts "Enter 2: Match2"
      puts "Enter 3: Match3"
      puts "Enter 4: Winner of this battle"
      puts "Enter 5: Go back to option"
      puts "Enter 6: To end the program"
      input = gets.to_i
      case input
      when 1
        battle.match(0)
      when 2
        battle.match(1)
      when 3
        battle.match(2)
      when 4
        battle.winner_for_battle
      when 5
        option
      when 6
        exit
      end
    end
  end
end