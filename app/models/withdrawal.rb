class Withdrawal < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  
  validates :currency, presence: true
  validates :status, inclusion: {in: %w[pending completed failed]}
  validates :customer, :company, presence: true
  validates :sufficient_balance

  def sufficient_balance
    errors.add(:amount, "Insufficient balance") unless amount < customer.balance
  end 
end
