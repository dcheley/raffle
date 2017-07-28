class ChangeQuantityType < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :quantity, :integer
  end
end
