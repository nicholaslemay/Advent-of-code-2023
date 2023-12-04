
class Game
  attr_accessor :id

  def self.built_from(instruction)
    game = Game.new
    game.id = instruction.scan(/Game (\d)/)[0][0]
    game
  end

end

RSpec.describe "Game" do

  describe 'built from record' do
    it 'has an id' do
      expect(Game.built_from('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green').id).to eq('1')
    end
  end

end

