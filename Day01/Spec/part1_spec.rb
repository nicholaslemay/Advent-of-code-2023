
class Calibration

  def self.first_digit_of(i)
    ''
  end
end

RSpec.describe "Calibration" do

  it 'return first digit of calibration value' do
    expect(Calibration.first_digit_of('')).to eq('')
  end
end

