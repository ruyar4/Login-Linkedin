class AddLocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :description, :string
    add_column :users, :headline, :string
    add_column :users, :urls, :string
    add_column :users, :industry, :string
  end
end
