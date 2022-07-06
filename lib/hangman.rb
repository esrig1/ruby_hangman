class Game 

    def initialize(word = [], curr_guesses = [], guesses_left = 0)
        @curr_guesses = curr_guesses
        @word = word
        @guesses_left = guesses_left
    end

    def is_winner? 
        if word == curr_guesses
            true
        else
            false
        end
    end

    def getLetter
        puts "Enter a letter as your guess, you currently have #{@guesses_left} guess(es) left"
        guess = gets.chomp 
    end
end



def get