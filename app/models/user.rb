class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :registerable, :trackable, :validatable

  has_many :transactions
  has_many :tickets, through: :transactions
end
