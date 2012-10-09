class Bathroom < ActiveRecord::Base
  belongs_to :bathroomtype
  has_many   :scores
  has_many   :scoretypes, :through => :scores
  has_many   :reviews
  attr_accessible :address, :city, :hasAttendent, :hasProductDispenser, :hasSignage, :hasWifi, :isFamily, :isGreen, :isHandicapAccessible, :isHandsFree, :isPublic, :isUnisex, :lat, :lng, :name, :state, :zip
  
  reverse_geocoded_by :lat, :lng
  after_validation :reverse_geocode  # auto-fetch address
end
