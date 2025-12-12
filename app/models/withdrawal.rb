class Withdrawal < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  
  validates :currency, presence: true
  validates :status, inclusion: {in: %w[pending completed failed]}
  validates :customer, :company, presence: true
  
end
