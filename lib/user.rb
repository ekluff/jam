class User < ActiveRecord::Base
  has_many(:instruments, :through => :sessions)
  validates(:first_name, {:presence => true, :format => { :with => /[A-Za-z]/ }})
  validates(:last_name, {:presence => true, :format => { :with => /[A-Za-z]/ }})
  validates(:username, {:presence => true, :uniqueness => true, :length => { :minimum => 6, :maximum => 15 }, :format => { :with => /\w/ }})
  validates(:phone, {:presence => true, :length => { :is => 10 }, :format => { :with => /\d/ }})
  validates(:email, {:presence => true, :uniqueness => true, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }})
  validates(:address, :presence => true)
  validates(:city, {:presence => true, :format => { :with => /[A-Za-z]/ }})
  validates(:state, {:presence => true, :length => { :is => 2 }, :format => { :with => /[A-Z]/ }})
  validates(:zip, {:presence => true, :length => { :is => 5 }, :format => { :with => /\d/ }})
  validates(:password, {:presence => true, :format => { :with => /\w(!*$)/ }, :length => {:minimum => 8, :maximum => 15 }})
  validates(:password_confirm, :uniqueness => true)
  before_save(:capitalize)

private

  define_method(:capitalize) do
    self.first_name=(first_name().strip().split(/(\W)/).map(&:capitalize).join)
    self.last_name=(last_name().strip().split(/(\W)/).map(&:capitalize).join)
  end
end
