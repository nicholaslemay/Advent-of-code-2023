
class GameSet
  attr_accessor :blue, :red, :green

  def initialize(set_instruction)
    @blue = @green = @red = 0
    %w(red green blue).each do |color|
      if(set_instruction =~ /(\d+) #{color}/)
        self.send("#{color}=", $1.to_i)
      end
    end
  end
end

class Game
  attr_accessor :id
  attr_accessor :sets

  def initialize(instruction)
    @sets = []
    @id = instruction.scan(/Game (\d+)/)[0][0]
    instruction.split(';').each do |part|
      @sets << GameSet.new(part)
    end
  end

  def is_possible?(treshold)
    sets.all?{|s| s.red <= treshold[:red] && s.blue <= treshold[:blue] && s.green <= treshold[:green] }
  end

end

RSpec.describe "Game" do

  describe 'built from record' do
    it 'has an id' do
      expect(Game.new('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').id).to eq('1')
      expect(Game.new('Game 12: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').id).to eq('12')
    end

    it 'has number or sets equal to number seperated by ; in instructions' do
      expect(Game.new('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').sets.length).to eq(3)
      expect(Game.new('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green').sets.length).to eq(2)
    end

    it 'has number or sets equal to number seperated by ; in instructions' do
      game = Game.new('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green')
      expect(game.sets[0].blue).to eq(3)
      expect(game.sets[0].red).to eq(4)
      expect(game.sets[0].green).to eq(0)
      expect(game.sets[1].green).to eq(2)
    end

    it 'can say whether a game is valid or not' do
      treshold = {:red=> 12, :green => 13, :blue => 14}
      expect(Game.new('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').is_possible?(treshold)).to eq(true)
      expect(Game.new('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue').is_possible?(treshold)).to eq(true)
      expect(Game.new('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red').is_possible?(treshold)).to eq(false)
      expect(Game.new('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red').is_possible?(treshold)).to eq(false)
      expect(Game.new('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green').is_possible?(treshold)).to eq(true)
    end

    it 'can resolve my riddle' do
      treshold = {:red=> 12, :green => 13, :blue => 14}

      result = File.readlines('Day02/day_02_input.txt', chomp:true).sum(0) do |i|
           game = Game.new(i)
           game.is_possible?(treshold) ? game.id.to_i : 0
        end
      expect(result).to eq(2239)

    end

  end

end


