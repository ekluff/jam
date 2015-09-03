class Session < ActiveRecord::Base
  has_and_belongs_to_many(:instruments)
  has_and_belongs_to_many(:users)
  validates(:address, :presence => true)
  validates(:city, {:presence => true, :format => { :with => /\A[A-Za-z\s]+\z/, :message => "only allows letters" }})
  validates(:state, {:presence => true, :length => { :is => 2 }, :format => { :with => /\A[A-Z]+\z/, :message => "only allows capital letters" }})
  validates(:zip, {:presence => true, :length => { :is => 5 }, :format => { :with => /\A\d+\z/, :message => "only allows numbers" }})
  validates(:date, :presence => true)
  validates(:time, :presence => true)
  validates(:host_id, :presence => true)
  before_save(:update_coordinates)

private
  define_method(:update_coordinates) do
    self.latitude=Geokit::Geocoders::GoogleGeocoder.geocode(address.concat(", ").concat(city).concat(", ").concat(state)).latitude
    self.longitude=Geokit::Geocoders::GoogleGeocoder.geocode(address.concat(", ").concat(city).concat(", ").concat(state)).longitude
  end
end
