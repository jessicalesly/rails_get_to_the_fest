class CreateLineUps < ActiveRecord::Migration[5.1]
  def change
    create_table :line_ups do |t|
      t.references :festival, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
