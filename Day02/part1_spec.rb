
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

  def is_possible?(treshold)
    sets.all?{|s| s.red <= treshold[:red] && s.blue <= treshold[:blue] && s.green <= treshold[:green] }
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

    it 'can say whether a game is valid or not' do
      treshold = {:red=> 12, :green => 13, :blue => 14}
      expect(Game.built_from('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').is_possible?(treshold)).to eq(true)
      expect(Game.built_from('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue').is_possible?(treshold)).to eq(true)
      expect(Game.built_from('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red').is_possible?(treshold)).to eq(false)
      expect(Game.built_from('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red').is_possible?(treshold)).to eq(false)
      expect(Game.built_from('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green').is_possible?(treshold)).to eq(true)
    end


    it 'can resolve my riddle' do
      treshold = {:red=> 12, :green => 13, :blue => 14}

      result = File.readlines('Day02/day_02_input.txt', chomp:true).sum(0) do |i|
           game = Game.built_from(i)
           game.is_possible?(treshold) ? game.id.to_i : 0
        end
      expect(result).to eq(2239)

    end

  end

end


