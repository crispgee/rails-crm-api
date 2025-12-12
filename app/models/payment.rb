class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :company

  validates :amount, numericality: {greater_than: 0} , presence: true
  validates :customer, :company, presence: true 
  validate :customer_company

  private
  
  def customer_company
    unless Membership.exists?(customer_id: customer.id, company_id: company.id)
      errors.add(:base, "Customer does not belong to this company")
    end 
  end 
end
