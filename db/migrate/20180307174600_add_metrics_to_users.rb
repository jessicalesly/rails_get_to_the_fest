class AddMetricsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nb_saved_tracks, :integer
    add_column :users, :nb_spotify_artists, :integer
  end
end
