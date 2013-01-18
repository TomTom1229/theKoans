# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

class GreedGame
	
	def initialize(players)
		@players = []
		@final = [] 
		@finalRound = false
		players.times do |num| @players << GreedPlayer.new(num) end
	end

	def play
		if @players.length == 0 then 
			gameOver 
			return	
		end
		currentPlayer = @players[-1]
		puts "It is Player #{currentPlayer.name}'s turn"
		puts "Current Score: #{currentPlayer.total}"
		currentPlayer.beginTurn
		if(currentPlayer.total >= 3000)
			@finalRound = true
		end
		if(@finalRound)
			@final << @players.pop
		else 
			@players.rotate!
		end
		play
	end

	def gameOver
		winner = @final.max_by { |player| player.total }
		puts "The Winner is Player #{winner.name}!"
	end

	def self.nonScoring(roll)
		dice = 0
		roll.delete(5) # All 5's Score
		roll.delete(1) # All 1's Score
		countHash = Hash.new(0)
		(1..6).each { |x| 
			countHash[x] = roll.count(x) 
		} 
		countHash.each { |die, num| 
			if num >= 3 
				countHash[die] = num%3 
			end
		}
		dice = countHash.inject(0) { |diceLeft, (die, num)| diceLeft + num }
		dice > 0 ? dice : 5
	end
end

class GreedPlayer
	attr_reader(:total)
	attr_reader(:name)

	def initialize(name)
		@name = name
		@total = 0
		@dice = DiceSet.new
	end

	def beginTurn
		@available = 5
		turn
	end

	def turn(rollingScore=0)
		@dice.roll(@available)
		roll = @dice.values
		puts "You Roll: #{roll}"
		thisTurnScore = score(roll)
		if thisTurnScore > 0
			rollingScore += thisTurnScore
			puts "You Score: #{thisTurnScore} for #{rollingScore} total this round."
			@available = GreedGame.nonScoring(roll)
			puts "You have #{@available} dice left, would you like to roll again?(Y or N)"
			if gets.chomp.upcase[0] == "Y"
				turn rollingScore
			else
				endTurn rollingScore
			end
		else
			puts "You scored 0, your turn is over"
			endTurn 0
		end
	end

	def endTurn(finalScore)
		if(@total >= 300 || finalScore >= 300)
			@total += finalScore
		end
	end
end

game = GreedGame.new(2)
game.play
