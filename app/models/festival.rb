class Festival < ApplicationRecord
  has_many :line_ups
  has_many :artists, through: :line_ups

  # def self.search(params)
  # @festivals = Festival.joins(line_ups: :artist)
  #             .where("artists.name IN (?)", @all_artists).distinct.pluck(:name)
  # end
end
