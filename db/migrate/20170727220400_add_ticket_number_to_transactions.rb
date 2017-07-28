class AddTicketNumberToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :ticket_number, :integer
  end
end
