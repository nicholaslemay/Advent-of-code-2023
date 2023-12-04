
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
      game.sets << ''
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
  end

end

