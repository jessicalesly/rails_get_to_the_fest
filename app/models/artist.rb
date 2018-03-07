class Artist < ApplicationRecord
  has_many :line_ups
  has_many :festivals, through: :line_ups
  belongs_to :user_artist
end
