class Ticket < ApplicationRecord
  belongs_to :transaction

  validates :number, uniqueness: true
end
