

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

def execute_game(game_object)
    while !game_object.is_winner? && game_object.guesses_left > 0
        game_object.get_letter
    end
    puts "end"
end

def save

end

def get_word 
    random = rand(0..9500)
    count = random
    lines = File.readlines("./dictionary.txt")
    word = lines[random].chomp
    while word.length < 5 && word&.length > 13 do
        count++
        word = lines[count].chomp
    end
    p word

end
get_word

word = ["p", "e", "n", "i", "s"]
empty = ["_","_","_","_","_"]
example = Game.new(word, empty, 5)
execute_game(example)


