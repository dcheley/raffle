class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :registerable, :trackable, :validatable

  has_many :transactions
end
