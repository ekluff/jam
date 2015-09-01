class Instrument < ActiveRecord::Base
  has_many(:users, :through => :sessions)
  validates(:name, :presence => true)
end
