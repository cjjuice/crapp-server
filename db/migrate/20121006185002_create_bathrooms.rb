class CreateBathrooms < ActiveRecord::Migration
  def change
    create_table :bathrooms do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.float :lat, :limit => 53
      t.float :lng, :limit => 53
      t.boolean :isHandicapAccessible
      t.boolean :isPublic
      t.boolean :isFamily
      t.boolean :isGreen
      t.boolean :isUnisex
      t.boolean :isHandsFree
      t.boolean :hasProductDispenser
      t.boolean :hasAttendent
      t.boolean :hasSignage
      t.boolean :hasWifi
      t.references :bathroomtype

      t.timestamps
    end
    add_index :bathrooms, :bathroomtype_id
  end
end
