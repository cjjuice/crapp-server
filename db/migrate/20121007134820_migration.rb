class Migration < ActiveRecord::Migration
  def self.up
    change_table :bathrooms do |t|
      t.change :lat, :float
      t.change :lng, :float
    end
  end
  def self.down
   change_table :bathrooms do |t|
      t.change :lat, :string
      t.change :lng, :string
   end
  end  
end
