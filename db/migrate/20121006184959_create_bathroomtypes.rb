class CreateBathroomtypes < ActiveRecord::Migration
  def change
    create_table :bathroomtypes do |t|
      t.string :btype

      t.timestamps
    end
  end
end
