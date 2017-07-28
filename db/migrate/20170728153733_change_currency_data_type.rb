class ChangeCurrencyDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :debt, :decimal, precision: 8, scale: 2
    change_column :transactions, :quantity, :decimal, precision: 8, scale: 2
  end
end
