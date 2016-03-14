class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :genre
      t.string :version
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
