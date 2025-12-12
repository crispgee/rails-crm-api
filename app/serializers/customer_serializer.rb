class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email , :balance
  
  has_many :companies_with_balance
  
  def companies_with_balance
    object.companies.map do |company|
      {
        id: company.id,
        name: company.name,
        registration_number: company.registration_number,
        balance: company.balance_for(object)
      }
    end 
  end 
end 