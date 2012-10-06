class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :reviewtext
      t.references :bathroom

      t.timestamps
    end
    add_index :reviews, :bathroom_id
  end
end
