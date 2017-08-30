class RenameColumnsForCsv < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :payee, :full_name
    rename_column :transactions, :debt, :price
    rename_column :transactions, :confirmation_number, :date_deposited
  end
end
