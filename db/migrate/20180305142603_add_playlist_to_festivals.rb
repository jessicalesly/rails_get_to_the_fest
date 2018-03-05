class AddPlaylistToFestivals < ActiveRecord::Migration[5.1]
  def change
    add_column :festivals, :playlist, :string
  end
end
