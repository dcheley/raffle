class AddStagesToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :confirmation_number, :integer
    add_column :transactions, :deposit_check, :integer

    rename_column :transactions, :status, :payment_check
  end
end
