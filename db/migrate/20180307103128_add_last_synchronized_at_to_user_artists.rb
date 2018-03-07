class AddLastSynchronizedAtToUserArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :user_artists, :last_synchronized_at, :datetime
  end
end
