class CreateScoretypes < ActiveRecord::Migration
  def change
    create_table :scoretypes do |t|
      t.string :stype

      t.timestamps
    end
  end
end
