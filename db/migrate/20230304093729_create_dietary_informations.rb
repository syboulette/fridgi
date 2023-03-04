class CreateDietaryInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :dietary_informations do |t|
      t.string :name
      t.string :allergy
      t.string :intolerance
      t.string :preference

      t.timestamps
    end
  end
end
