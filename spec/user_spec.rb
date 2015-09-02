require('spec_helper')

describe(User) do
  it { should have_many(:instruments).through(:sessions) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:phone).is_equal_to(10) }
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should validate_length_of(:zip).is_equal_to(5) }
  it { should validate_length_of(:username).is_at_least(6).is_at_most(15) }
  it { should validate_length_of(:password).is_at_least(8).is_at_most(15) }
  it { should allow_value("Billie-Jean").for(:first_name) }
  it { should_not allow_value("B0b").for(:first_name).with_message("only allows letters") }
  it { should allow_value("Peters-Parker").for(:last_name) }
  it { should_not allow_value("B0b").for(:last_name).with_message("only allows letters") }
  it { should allow_value("Us3r_Name").for(:username) }
  it { should_not allow_value("User_Name!").for(:username).with_message("only allows letters, numbers and underscore") }
  it { should allow_value("9998887777").for(:phone) }
  it { should_not allow_value("fkljdaklfjd").for(:phone).with_message("only allows numbers") }
  it { should allow_value("alexa@yahoo.com").for(:email) }
  it { should_not allow_value("alexa@yahoo.com.adsfads").for(:email).with_message("only allows email formatting") }
  it { should allow_value("Culver City").for(:city) }
  it { should_not allow_value("Culv3r City").for(:city).with_message("only allows letters") }
  it { should allow_value("OR").for(:state) }
  it { should_not allow_value("Oregon").for(:state).with_message("only allows capital letters") }
  it { should allow_value("92342").for(:zip) }
  it { should_not allow_value("hjkdah").for(:zip).with_message("only allows numbers") }
  it { should allow_value("ter5!4dff").for(:password) }
  it { should_not allow_value("djdjdjd%%%%").for(:password).with_message("must have at least 1 number") }
end
