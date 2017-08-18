class RemoveTicketNumbers < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :ticket_numbers
  end
end
