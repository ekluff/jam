require('spec_helper')

describe(Session) do
  it { should belong_to(:user) }
  it { should belong_to(:instrument) }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should validate_length_of(:zip).is_equal_to(5) }
  it { should allow_value("Culver City").for(:city) }
  it { should_not allow_value("Culv3r City").for(:city).with_message("only allows letters") }
  it { should allow_value("OR").for(:state) }
  it { should_not allow_value("Oregon").for(:state).with_message("only allows capital letters") }
  it { should allow_value("92342").for(:zip) }
  it { should_not allow_value("hjkdah").for(:zip).with_message("only allows numbers") }
end
