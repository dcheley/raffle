require 'csv'

class Transaction < ApplicationRecord
  belongs_to :user
  has_many :tickets

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => [:create, :update] }
  validates :full_name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.to_csv
    attributes = %w{full_name email ministry quantity price payment_check deposit_check date_deposited}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |transaction|
        csv << attributes.map{ |attr| transaction.send(attr) }
      end
    end
  end
end
