require 'csv'

class Transaction < ApplicationRecord
  belongs_to :user
  has_many :tickets

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => [:create, :update] }
  validates :payee, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :debt, numericality: { greater_than_or_equal_to: 0 }

  def self.to_csv
    attributes = %w{payee email ministry quantity debt}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |transaction|
        csv << attributes.map{ |attr| transaction.send(attr) }
      end
    end
  end
end
