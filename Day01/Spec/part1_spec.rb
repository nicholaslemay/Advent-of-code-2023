
class Calibration

  def self.calibration_of_instruction(instruction)
    "#{self.digit_at_position(instruction, :first)}#{self.digit_at_position(instruction, :last)}".to_i
  end

  def self.digit_at_position(instruction, position)
    instruction.scan(/\d/).send(position) || ''
  end

end

RSpec.describe "Calibration" do

  it 'return first digit of calibration value' do
    expect(Calibration.digit_at_position('', :first)).to eq('')
    expect(Calibration.digit_at_position('1abc2', :first)).to eq('1')
    expect(Calibration.digit_at_position('pqr3stu8vwx', :first)).to eq('3')
    expect(Calibration.digit_at_position('eight47vrvjlpgcqthree87q', :first)).to eq('4')

  end

  it 'return last digit of calibration value' do
    expect(Calibration.digit_at_position('', :last)).to eq('')
    expect(Calibration.digit_at_position('treb7uchet', :last)).to eq('7')
    expect(Calibration.digit_at_position('1abc2', :last)).to eq('2')
    expect(Calibration.digit_at_position('eight47vrvjlpgcqthree39q', :last)).to eq('9')
  end

  it 'returns calibration of single instruction' do
    expect(Calibration.calibration_of_instruction('1abc2')).to eq(12)
  end

  it 'solves provided sample' do
    sample_result = %w(1abc2 pqr3stu8vwx a1b2c3d4e5f treb7uchet).sum(0){|i| Calibration.calibration_of_instruction(i)}
    expect(sample_result).to eq(142)
  end

  it 'solves my own input data' do
    result = File.readlines('Day01/Spec/day_01_input.txt', chomp:true).sum(0){|i| Calibration.calibration_of_instruction(i)}
    expect(result).to eq(53921)
  end
end

