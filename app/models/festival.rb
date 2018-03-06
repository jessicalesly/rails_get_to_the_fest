class Festival < ApplicationRecord
  has_many :line_ups
  has_many :artists, through: :line_ups

  include PgSearch
  pg_search_scope :global_fest,
    against: [:name, :city, :start_date, :end_date],
    associated_against: {
      artists: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
