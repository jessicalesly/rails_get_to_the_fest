class AddTicketsToFestivals < ActiveRecord::Migration[5.1]
  def change
    add_column :festivals, :tickets_link, :string
  end
end
