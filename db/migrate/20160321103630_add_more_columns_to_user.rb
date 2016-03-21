class AddMoreColumnsToUser < ActiveRecord::Migration
  def change
    rename_column :users, :photo, :photo_url
    add_column :users, :refresh_token, :string
    add_column :users, :token_expires_at, :datetime
  end
end
