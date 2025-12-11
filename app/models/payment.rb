class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :company

  validates :currency, presence: true
  validates :amount, numericalty: {greater_than: 0} , presence: true
  validates :customer, :company, presence: true 
end
