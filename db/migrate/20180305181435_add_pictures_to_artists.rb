class AddPicturesToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :picture, :string
  end
end
