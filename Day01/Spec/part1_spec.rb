
class Calibration

  def self.calibration_of_instruction(instruction)
    "#{self.first_digit_of(instruction).to_i}#{self.last_digit_of(instruction)}".to_i
  end

  def self.first_digit_of(instruction)
    self.get_match_from_regex_or_empty(instruction, /^\D*(\d)/)
  end

  def self.last_digit_of(instruction)
    self.get_match_from_regex_or_empty(instruction, /(\d)\D*\Z/)
  end

  private

  def self.get_match_from_regex_or_empty(string, regexp)
    match = string.match(regexp)

    match.nil? ? '' : match[1]
  end

end

RSpec.describe "Calibration" do

  it 'return first digit of calibration value' do
    expect(Calibration.first_digit_of('')).to eq('')
    expect(Calibration.first_digit_of('1abc2')).to eq('1')
    expect(Calibration.first_digit_of('pqr3stu8vwx')).to eq('3')
    expect(Calibration.first_digit_of('eight47vrvjlpgcqthree87q')).to eq('4')

  end

  it 'return last digit of calibration value' do
    expect(Calibration.last_digit_of('')).to eq('')
    expect(Calibration.last_digit_of('treb7uchet')).to eq('7')
    expect(Calibration.last_digit_of('1abc2')).to eq('2')
    expect(Calibration.last_digit_of('eight47vrvjlpgcqthree39q')).to eq('9')
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

