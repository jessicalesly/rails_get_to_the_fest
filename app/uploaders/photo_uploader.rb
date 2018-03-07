class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'png'

  version :artist_avatar do
    eager
    cloudinary_transformation :transformation => [
        {:height => 150, :radius => "max", :width => 150, :crop => "thumb"},
        {:crop => "crop"}
      ]
  end
end


