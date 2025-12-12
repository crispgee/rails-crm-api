class Company < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :customers, through: :memberships 
  has_many :payments
  has_many :withdrawals

  validates :name, presence: true
  validates :industry, presence: true
  validates :registration_number, presence: true, uniqueness: true
  
  def balance 
    payments.sum(:amount).to_f - withdrawals.sum(:amount).to_f
  end 

  def balance_for(customer)
    customer.payments.where(company_id: id).sum(:amount).to_f - customer.withdrawals.where(company_id: id).sum(:amount).to_f
  end 

end
