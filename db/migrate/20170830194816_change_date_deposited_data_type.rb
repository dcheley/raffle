class ChangeDateDepositedDataType < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :date_deposited
    add_column :transactions, :date_deposited, :date
  end
end
