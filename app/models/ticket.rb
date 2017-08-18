require 'csv'

class Ticket < ApplicationRecord
  belongs_to :payment, foreign_key: :transaction_id, class_name: :Transaction

  validates :number, uniqueness: true

  def self.to_csv
    attributes =  %w{number}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |ticket|
        csv << attributes.map{ |attr| ticket.send(attr) }
      end
    end
  end
end
