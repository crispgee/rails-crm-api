class Withdrawal < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  
  validates :amount, numericality: {greater_than: 0}, presence: true
  validates :customer, :company, presence: true
  validate :sufficient_balance
  validate :customer_company

  private
  def sufficient_balance
    return unless company && customer
    if amount > company.balance_for(customer)
      errors.add(:amount, "Insufficient Balance")
    end 
  end 

   def customer_company
    unless Membership.exists?(customer_id: customer.id, company_id: company.id)
      errors.add(:base, "customer does not belong to this company")
    end 
  end 
end
