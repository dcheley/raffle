class Transaction < ApplicationRecord
  belongs_to :user

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => [:create, :update] }
  validates :payee, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :debt, numericality: { greater_than_or_equal_to: 0 }
end
