require('bcrypt')

class User < ActiveRecord::Base
  has_many(:sessions)
  has_many(:instruments, :through => :sessions)
  validates(:first_name, {:presence => true, :format => { :with => /\A[a-zA-Z]+\z/, :message => "only allows letters" }})
  validates(:last_name, {:presence => true, :format => { :with => /\A[a-zA-Z]+\z/, :message => "only allows letters" }})
  validates(:username, {:presence => true, :uniqueness => true, :length => { :minimum => 6, :maximum => 15 }, :format => { :with => /\A\w+\z/, :message => "only allows letters, numbers and underscore" }})
  validates(:phone, {:presence => true, :length => { :is => 10 }, :format => { :with => /\A\d+\z/, :message => "only allows numbers" }})
  validates(:email, {:presence => true, :uniqueness => true, format: { :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i, :message => "only allows email formatting" }})
  validates(:address, :presence => true)
  validates(:city, {:presence => true, :format => { :with => /\A[A-Za-z\s]+\z/, :message => "only allows letters" }})
  validates(:state, {:presence => true, :length => { :is => 2 }, :format => { :with => /\A[A-Z]+\z/, :message => "only allows capital letters" }})
  validates(:zip, {:presence => true, :length => { :is => 5 }, :format => { :with => /\A\d+\z/, :message => "only allows numbers" }})
  validates(:password, {:presence => true, :format => { :with => /\d/, :message => "must have at least 1 number" }, :length => {:minimum => 8, :maximum => 15 }})
  # need to move password confirmation to app.rb to allow for encryption
  validates(:password_confirm, :uniqueness => true)
  before_save(:capitalize)

  def authenticate(entered_password)
    if BCrypt::Password.new(self.password) == entered_password
      return true
    else
      return false
    end
  end

  private

  define_method(:capitalize) do
    self.first_name=(first_name().strip().split(/(\W)/).map(&:capitalize).join)
    self.last_name=(last_name().strip().split(/(\W)/).map(&:capitalize).join)
  end

end