class AddLastSynchronizedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_synchronized_at, :datetime
  end
end
