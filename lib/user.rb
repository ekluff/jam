class User < ActiveRecord::Base
  has_many(:instruments, :through => :sessions)
  validates(:first_name, {:presence => true, :format => { :with => /\A[a-zA-Z]+\z/ }})
  validates(:last_name, {:presence => true, :format => { :with => /\A[a-zA-Z]+\z/ }})
  validates(:username, {:presence => true, :uniqueness => true, :length => { :minimum => 6, :maximum => 15 }, :format => { :with => /\A\w+\z/ }})
  validates(:phone, {:presence => true, :length => { :is => 10 }, :format => { :with => /\A\d+\z/ }})
  validates(:email, {:presence => true, :uniqueness => true, format: { :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i }})
  validates(:address, :presence => true)
  validates(:city, {:presence => true, :format => { :with => /\A[A-Za-z\s]+\z/ }})
  validates(:state, {:presence => true, :length => { :is => 2 }, :format => { :with => /\A[A-Z]+\z/ }})
  validates(:zip, {:presence => true, :length => { :is => 5 }, :format => { :with => /\A\d+\z/ }})
  validates(:password, {:presence => true, :format => { :with => /\d/ }, :length => {:minimum => 8, :maximum => 15 }})
  validates(:password_confirm, :uniqueness => true)
  before_save(:capitalize)

private

  define_method(:capitalize) do
    self.first_name=(first_name().strip().split(/(\W)/).map(&:capitalize).join)
    self.last_name=(last_name().strip().split(/(\W)/).map(&:capitalize).join)
  end
end
