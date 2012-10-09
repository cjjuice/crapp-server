class ChangeLatAndLngToDoublePercision < ActiveRecord::Migration
  def self.up
    change_table :bathrooms do |t|
        t.change :lat, :float, :limit => 53
        t.change :lng, :float, :limit => 53
    end
  end
  def self.down
   change_table :bathrooms do |t|
        t.change :lat, :string
        t.change :lng, :string
   end
  end  
end
