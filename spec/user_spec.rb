require('spec_helper')

describe(User) do
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
end
