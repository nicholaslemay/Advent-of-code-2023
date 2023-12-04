
class GameSet
  attr_accessor :blue, :red, :green

  def initialize
    @blue = @green = @red = 0
  end

  def self.built_from(set_instruction)
    set = GameSet.new

    if(set_instruction =~ /(\d+) blue/)
      set.blue = $1.to_i
    end

    if(set_instruction =~ /(\d+) red/)
      set.red = $1.to_i
    end

    if(set_instruction =~ /(\d+) green/)
      set.green = $1.to_i
    end

    set
  end
end

class Game
  attr_accessor :id
  attr_accessor :sets

  def initialize
    @sets = []
  end

  def self.built_from(instruction)
    game = Game.new
    game.id = instruction.scan(/Game (\d+)/)[0][0]
    instruction.split(';').each do |part|
      game.sets << GameSet.built_from(part)
    end
    game
  end

end

RSpec.describe "Game" do

  describe 'built from record' do
    it 'has an id' do
      expect(Game.built_from('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').id).to eq('1')
      expect(Game.built_from('Game 12: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').id).to eq('12')
    end

    it 'has number or sets equal to number seperated by ; in instructions' do
      expect(Game.built_from('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').sets.length).to eq(3)
      expect(Game.built_from('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green').sets.length).to eq(2)
    end


    it 'has number or sets equal to number seperated by ; in instructions' do
      game = Game.built_from('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green')
      expect(game.sets[0].blue).to eq(3)
      expect(game.sets[0].red).to eq(4)
      expect(game.sets[0].green).to eq(0)
      expect(game.sets[1].green).to eq(2)
    end
  end

end

