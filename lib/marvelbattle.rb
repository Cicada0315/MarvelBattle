class Marvel_Battle
  attr_accessor :player, :computer, :player_totalpoint, :computer_totalpoint, :player_winpoint, :computer_winpoint
  def initialize(player, computer)
    @player=player
    @computer=computer
    @player_totalpoint=0
    @computer_totalpoint=0
    @player_winpoint=0
    @computer_winpoint=0
  end

  def display_ring
    puts "#{player.name} VS Computer"
    puts "Match1: #{player.my_characters_arr[0].name} VS #{computer.character_arr[0].name}"
    puts "------------------------------------------------------"
    puts "Match2: #{player.my_characters_arr[1].name} VS #{computer.character_arr[1].name}"
    puts "------------------------------------------------------"
    puts "Match3: #{player.my_characters_arr[2].name} VS #{computer.character_arr[2].name}"
    puts "------------------------------------------------------"
  end

  def get_durability(arr, index)
    durability= arr[index].abilities["durability"].to_i 
  end

  def get_energy(arr, index)
    energy= arr[index].abilities["energy"].to_i
  end

  def get_fighting_skills(arr, index)
    fighting_skills= arr[index].abilities["fighting skills"].to_i
  end

  def get_intelligence(arr, index)
    intelligence= arr[index].abilities["intelligence"].to_i
  end

  def get_speed(arr, index)
    speed= arr[index].abilities["speed"].to_i
  end

  def get_strength(arr, index)
    strength=arr[index].abilities["strength"].to_i
  end

  def compare(player_ability, computer_ability)
    if player_ability>computer_ability
      @player_totalpoint+=1
    elsif computer_ability> player_ability
      @computer_totalpoint+=1
    end
  end

  def character_winner(index)
    if @player_totalpoint > @computer_totalpoint 
      @winner="#{player.name}: #{player.my_characters_arr[index].name}"
      @player_winpoint+=1
    elsif @computer_totalpoint> @player_totalpoint 
      @winner="Computer: #{computer.character_arr[index].name}"
      @computer_winpoint+=1
    else
      @winner="Draw"
    end
    @winner
  end

  def match_result(character_winner)
    puts "player: #{@player_totalpoint} computer: #{@computer_totalpoint}"
    if character_winner == "Draw"
      puts "Draw"
    else
      puts "Winner is #{character_winner}"
    end
  end

  def match(index)
    puts "----------------------------------"
    puts "Match#{index}: #{player.my_characters_arr[index].name} VS #{computer.character_arr[index].name}"
    puts "----------------------------------"
    compare(get_durability(player.my_characters_arr, index), get_durability(computer.character_arr, index))
    compare(get_energy(player.my_characters_arr, index), get_energy(computer.character_arr, index))
    compare(get_fighting_skills(player.my_characters_arr, index), get_fighting_skills(computer.character_arr, index))
    compare(get_intelligence(player.my_characters_arr, index), get_intelligence(computer.character_arr, index))
    compare(get_speed(player.my_characters_arr, index), get_speed(computer.character_arr, index))
    compare(get_strength(player.my_characters_arr, index), get_strength(computer.character_arr, index))
  
    character_winner(index)
    match_result(character_winner(index))
    @player_totalpoint=0
    @computer_totalpoint=0
  end

  def winner_for_battle
    if @player_winpoint > @computer_winpoint 
      puts "You are the winner!"
      
    elsif @computer_winpoint> @player_winpoint
      puts "You lost, try again. Keep Fighting for the justice"
    else
      puts "No one won.."
    end
  end
end

# #to check what is going on
# def match(index)
#   puts "----------------------------------"
#   puts "Match#{index}: #{player.my_characters_arr[index].name} VS #{computer.character_arr[index].name}"
#   puts "----------------------------------"
#   puts "#{get_durability(player.my_characters_arr, index)}, #{get_durability(computer.character_arr, index)}"
#   puts "#{get_energy(player.my_characters_arr, index)}, #{get_energy(computer.character_arr, index)}"
#   puts "#{get_fighting_skills(player.my_characters_arr, index)}, #{get_fighting_skills(computer.character_arr, index)}"
#   puts "#{get_intelligence(player.my_characters_arr, index)}, #{get_intelligence(computer.character_arr, index)}"
#   puts "#{get_speed(player.my_characters_arr, index)}, #{get_speed(computer.character_arr, index)}"
#   puts "#{get_strength(player.my_characters_arr, index)}, #{get_strength(computer.character_arr, index)}"

#   compare(get_durability(player.my_characters_arr, index), get_durability(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   compare(get_energy(player.my_characters_arr, index), get_energy(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   compare(get_fighting_skills(player.my_characters_arr, index), get_fighting_skills(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   compare(get_intelligence(player.my_characters_arr, index), get_intelligence(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   compare(get_speed(player.my_characters_arr, index), get_speed(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   compare(get_strength(player.my_characters_arr, index), get_strength(computer.character_arr, index))
#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
#   character_winner(index)
#   match_result(character_winner(index))
#   @player_totalpoint=0
#   @computer_totalpoint=0

#   puts "#{@player_totalpoint}, #{@computer_totalpoint}"
# end