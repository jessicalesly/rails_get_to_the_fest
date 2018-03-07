class Artist < ApplicationRecord
  has_many :line_ups
  has_many :festivals, through: :line_ups
  mount_uploader :cloudinary_picture, PhotoUploader
end
