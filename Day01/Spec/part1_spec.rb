
class Calibration

  def self.first_digit_of(instruction)
    match = instruction.match(/^\D*(\d+)/)

    match.nil? ? '' : match[1]
  end
end

RSpec.describe "Calibration" do

  it 'return first digit of calibration value' do
    expect(Calibration.first_digit_of('')).to eq('')
    expect(Calibration.first_digit_of('1abc2')).to eq('1')
    expect(Calibration.first_digit_of('pqr3stu8vwx')).to eq('3')
  end
end

