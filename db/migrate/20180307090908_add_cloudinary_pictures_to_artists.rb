class AddCloudinaryPicturesToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :cloudinary_picture, :string
  end
end
