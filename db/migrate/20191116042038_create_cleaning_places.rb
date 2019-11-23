class CreateCleaningPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :cleaning_places do |t|
      t.string :name
      t.string :person_in_charge

      t.timestamps
    end
  end
end
