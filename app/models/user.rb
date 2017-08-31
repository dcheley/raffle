class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :registerable, :trackable, :validatable, :confirmable

  has_many :transactions
  has_many :tickets, through: :transactions

  validates :name, presence: true
end
