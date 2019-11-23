class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.integer :cleaning_place_id
      t.integer :user_id
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
