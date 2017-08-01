class ChangeTicketNumberToArray < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :ticket_number

    add_column :transactions, :ticket_numbers, :integer, array: true, default: []
  end
end
