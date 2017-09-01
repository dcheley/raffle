class AddSentColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :sent_confiramtion, :integer
  end
end
