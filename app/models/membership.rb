class Membership < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  validates :customer_id, uniqueness: {scope: :company_id}
end
