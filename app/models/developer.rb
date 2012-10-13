class Developer < ActiveRecord::Base
  has_secure_password
  
  has_one :api_key
  
  before_create :set_access_token
  
  attr_accessible :email, :password, :password_confirmation

  validates_uniqueness_of :email
  
  def set_access_token
       self.api_key = ApiKey.create!
  end
end
