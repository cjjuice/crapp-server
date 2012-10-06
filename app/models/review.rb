class Review < ActiveRecord::Base
  belongs_to :bathroom
  attr_accessible :reviewtext
end
