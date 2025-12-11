class Customer < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships
  has_many :payments
  has_many :withdrawals

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :status, presence: true

 private
 def balance
    payments.sum(:amount).to_f - withdrawals.sum(:amount).to_f
 end 
end
