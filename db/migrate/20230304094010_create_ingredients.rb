class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :nutriscore
      t.string :name
      t.date :expiry_date

      t.timestamps
    end
  end
end
