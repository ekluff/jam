require('spec_helper')

describe(Session) do
  it { should belong_to(:user) }
  it { should belong_to(:instrument) }
end
