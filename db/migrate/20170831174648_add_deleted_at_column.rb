class AddDeletedAtColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :deleted_at, :timestamp
  end
end
