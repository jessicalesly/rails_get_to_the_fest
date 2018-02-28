class Festival < ApplicationRecord
  has_many :line_ups
  has_many :artists, through: :line_ups
end
