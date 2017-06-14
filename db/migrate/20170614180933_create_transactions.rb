class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :payee
      t.float :quantity
      t.float :debt
      t.string :email
      t.string :ministry
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
