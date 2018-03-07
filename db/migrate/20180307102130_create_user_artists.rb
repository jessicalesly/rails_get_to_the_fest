class CreateUserArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :user_artists do |t|
      t.boolean :is_top_artist
      t.boolean :is_related
      t.integer :nb_top_tracks
      t.integer :nb_saved_tracks
      t.integer :score
      t.references :artist, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
