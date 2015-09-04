require('bcrypt')
require('pry')

class User < ActiveRecord::Base
  
  attr_accessor :image

  has_and_belongs_to_many(:instruments)
  has_and_belongs_to_many(:sessions)

  validates(:first_name, {:presence => true, :format => { :with => /\A[a-zA-Z\s\-]+\z/, :message => "only allows letters" }})
  validates(:last_name, {:presence => true, :format => { :with => /\A[a-zA-Z\s\-]+\z/, :message => "only allows letters" }})
  validates(:username, {:presence => true, :uniqueness => true, :length => { :minimum => 6, :maximum => 15 }, :format => { :with => /\A\w+\z/, :message => "only allows letters, numbers and underscore" }})
  validates(:phone, {:presence => true, :length => { :is => 10 }, :format => { :with => /\A\d+\z/, :message => "only allows numbers" }})
  validates(:email, {:presence => true, :uniqueness => true, format: { :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i, :message => "only allows email formatting" }})
  validates(:address, :presence => true)
  validates(:city, {:presence => true, :format => { :with => /\A[A-Za-z\s]+\z/, :message => "only allows letters" }})
  validates(:state, {:presence => true, :length => { :is => 2 }, :format => { :with => /\A[A-Z]+\z/, :message => "only allows capital letters" }})
  validates(:zip, {:presence => true, :length => { :is => 5 }, :format => { :with => /\A\d+\z/, :message => "only allows numbers" }})
  validates(:password, {:presence => true, :format => { :with => /\d/, :message => "must have at least 1 number" }, :length => {:minimum => 8}})
  after_initialize :init
  before_save(:capitalize_name)

  include Paperclip::Glue

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                            :default_url => "/img/avatar/default.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def authenticate(entered_password)
    if BCrypt::Password.new(self.password) == entered_password
      return true
    else
      return false
    end
  end

  private

  def init
    self.image_url ||= "/img/avatar/default.png"
    self.image_file_name ||= "default.png"
  end

  define_method(:capitalize_name) do
    self.first_name=(first_name().strip().split(/(\W)/).map(&:capitalize).join)
    self.last_name=(last_name().strip().split(/(\W)/).map(&:capitalize).join)
  end

end
