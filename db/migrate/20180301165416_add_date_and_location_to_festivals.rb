class AddDateAndLocationToFestivals < ActiveRecord::Migration[5.1]
  def change
    add_column :festivals, :start_date, :string
    add_column :festivals, :end_date, :string
    add_column :festivals, :city, :string
    add_column :festivals, :country, :string
  end
end
