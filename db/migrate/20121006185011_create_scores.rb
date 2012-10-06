class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value
      t.references :bathroom
      t.references :scoretype

      t.timestamps
    end
    add_index :scores, :bathroom_id
    add_index :scores, :scoretype_id
  end
end
