class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :registration_number, :balance
  has_many :customers_with_balance

  def customers_with_balance
    object.customers.map do |customer|
      {
        id: customer.id,
        firstname: customer.first_name,
        lastname: customer.last_name,
        email: customer.email,
        balance: customer.balance_for(object)
      }
    end 
  end 
end 