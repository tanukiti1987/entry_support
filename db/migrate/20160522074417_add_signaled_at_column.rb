class AddSignaledAtColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :indicators, :signaled_at, :datetime
  end
end
