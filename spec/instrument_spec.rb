require('spec_helper')

describe(Instrument) do
  it { should validate_presence_of(:name) }
  it { should have_and_belong_to_many(:users) }
  it { should have_and_belong_to_many(:sessions) }
end
