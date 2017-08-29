class Ticket < ApplicationRecord
  belongs_to :payment, foreign_key: :transaction_id, class_name: :Transaction

  validates :number, uniqueness: true
end
