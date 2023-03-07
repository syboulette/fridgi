class AddAttributesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :language, :string
    # add_column :users, :address, :string
    # add_column :users, :country, :string
    # add_column :users, :city, :string
    # add_column :users, :post_code, :string
  end
end
