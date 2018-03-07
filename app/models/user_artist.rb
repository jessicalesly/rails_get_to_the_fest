class UserArtist < ApplicationRecord
  belongs_to :artist
  belongs_to :user
  validates :artist, presence: true
  validates :user, presence: true
end
