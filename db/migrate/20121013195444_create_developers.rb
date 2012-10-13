class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
