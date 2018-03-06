class Festival < ApplicationRecord
  has_many :line_ups
  has_many :artists, through: :line_ups

  include PgSearch
  pg_search_scope :search_by_localisation,
    against: [:city, :country],
    using: {
      tsearch: { prefix: true }
    }
  pg_search_scope :search_by_artist,
    associated_against: {
      artists: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

end
