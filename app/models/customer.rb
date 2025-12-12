class Customer < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships
  has_many :payments
  has_many :withdrawals

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

 def balance
    payments.sum(:amount).to_f - withdrawals.sum(:amount).to_f
 end 

 def balance_for(company)
   company.payments.where(customer_id: id).sum(:amount).to_f - company.withdrawals.where(customer_id: id).sum(:amount).to_f
 end 
end
