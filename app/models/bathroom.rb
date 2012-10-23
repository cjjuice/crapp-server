class Bathroom < ActiveRecord::Base
  belongs_to :bathroomtype
  has_many   :scores
  has_many   :scoretypes, :through => :scores
  has_many   :reviews
  attr_accessible :address, :city, :hasAttendent, :hasProductDispenser, :hasSignage, :hasWifi, :isFamily, :isGreen, :isHandicapAccessible, :isHandsFree, :isPublic, :isUnisex, :lat, :lng, :name, :state, :zip
  
  def full_address
    [address, city, state, zip].compact.join(', ')
  end
  
  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng   # can also be an IP address
  after_validation :geocode   # auto-fetch coordinates 

  reverse_geocoded_by :lat, :lng do |obj,results|
   if geo = results.first
     obj.address = geo.address.split(/,/).first
     obj.city  = geo.city
     obj.state = geo.state_code
     obj.zip = geo.postal_code
   end
  end
   
    after_validation :reverse_geocode  # auto-fetch address   
    
end
