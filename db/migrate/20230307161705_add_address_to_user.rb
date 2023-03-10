class AddAddressToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :post_code, :string
  end
end
