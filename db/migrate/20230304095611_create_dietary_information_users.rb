class CreateDietaryInformationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :dietary_information_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dietary_information, null: false, foreign_key: true

      t.timestamps
    end
  end
end
