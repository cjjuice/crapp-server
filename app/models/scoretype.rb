class Scoretype < ActiveRecord::Base
  has_many :scores
  has_many :bathrooms, :through => :scores
  attr_accessible :stype
end
