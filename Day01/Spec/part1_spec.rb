
class Calibration

  def self.first_digit_of(instruction)
    self.get_match_from_regex_or_empty(instruction)
  end

  def self.last_digit_of(instruction)
    self.get_match_from_regex_or_empty(instruction)
  end

  private

  def self.get_match_from_regex_or_empty(string)
    match = string.match(/^\D*(\d+)/)

    match.nil? ? '' : match[1]
  end

end

RSpec.describe "Calibration" do

  it 'return first digit of calibration value' do
    expect(Calibration.first_digit_of('')).to eq('')
    expect(Calibration.first_digit_of('1abc2')).to eq('1')
    expect(Calibration.first_digit_of('pqr3stu8vwx')).to eq('3')
  end

  it 'return last digit of calibration value' do
    expect(Calibration.last_digit_of('')).to eq('')
    expect(Calibration.last_digit_of('treb7uchet')).to eq('7')
  end
end

