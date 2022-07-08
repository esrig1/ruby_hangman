require "yaml"

class Game 

    def initialize(word = [], curr_guesses = [], guesses_left = 0)
        @curr_guesses = curr_guesses
        @word = word
        @guesses_left = guesses_left
    end

    def is_winner? 
        if @word == @curr_guesses
            true
        else
            false
        end
    end

    def word
        return @word
    end

    def guesses_left
        return @guesses_left
    end
    
    def display_board 
        @curr_guesses.each do |letter| 
            print "#{letter} "
        end
        puts
    end

    def get_letter
        correct_guess = false
        puts "Enter a letter as your guess, you currently have #{@guesses_left} wrong guess(es) left"
        guess = gets.chomp.downcase
        if guess == "save"
            save(self)
            return 1
        end
        
        @word.each_with_index do |char, index|
            if char.eql?(guess)
                @curr_guesses[index] = guess.to_str
                correct_guess = true
            end
        end
        display_board
        if not correct_guess
            @guesses_left -= 1
        end
    end

end

def execute_game(game_object = nil)
    word = get_word
    empty = get_blank_board(word)
    if game_object == nil
        game_object = Game.new(word, empty, 7)
    end
    print game_object.display_board
    while !game_object.is_winner? && game_object.guesses_left > 0
        save_check = game_object.get_letter
        if save_check == 1
            break
        end
    end
    if game_object.guesses_left == 0 
        puts "The correct word was #{game_object.word.join}"
    elsif game_object.is_winner?
        puts "You Win!"
    end
    puts "end"
end

def get_word 
    random = rand(0..9500)
    count = random.to_int
    lines = File.readlines("./dictionary.txt")
    word = lines[random].chomp
    while word.length < 5 || word&.length > 13 do
        count++
        word = lines[count].chomp
    end
    return word.split("")

end

def get_blank_board(word)
    blank = []
    word.length.times do |i| 
        blank.push("_")
    end
    return blank
end


def save(curr_game)
    
    if !Dir.exists?("saves")
        Dir.mkdir("saves")
    end
    puts "Enter a name for your save file"
    name = gets.chomp
    puts name
    File.open("saves/#{name}.yml", "w") do |f| 
        f.write(curr_game.to_yaml) 
        f.close
    end
    
    puts "Your game has been saved!"
    menu

end

def load(file_name)
    #begin
    saved = File.open("saves/#{file_name}")
    loaded_game = YAML.load(saved,  permitted_classes: [Game])
    saved.close
    return loaded_game
    
    #rescue
        #puts "invalid file name, enter a file that exists. Otherwise press e to exit"
        #input = gets.chomp
        #if input == "e"
        #    return
        #else
        #load(file_name)
        #end
    #end
    
end

def menu
    puts "Enter 1 to start a new game, or 2 to load a save"
    user_response = gets.chomp
    if user_response == "1"
        execute_game()
    elsif user_response == "2"
        puts "enter the name of your save file"
        save_filename = gets.chomp
        loaded_game = load(save_filename)
        execute_game(loaded_game)
    else 
        puts "invalid response, please try again"
        menu
    end

end


menu


