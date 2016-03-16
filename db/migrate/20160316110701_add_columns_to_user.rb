class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :description, :text
    add_column :users, :followers_count, :integer
    add_column :users, :public_favorites_count, :integer
    add_column :users, :upload_seconds_left, :integer
    add_column :users, :uid, :integer
  end
end
