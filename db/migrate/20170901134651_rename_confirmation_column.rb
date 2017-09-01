class RenameConfirmationColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :sent_confiramtion, :sent_confirmation
  end
end
