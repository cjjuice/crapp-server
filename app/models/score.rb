class Score < ActiveRecord::Base
  belongs_to :bathroom
  belongs_to :scoretype
  attr_accessible :value
end
