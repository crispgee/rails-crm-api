class PaymentCreator 
  def self.create(company:, customer: , amount:)
    Payment.create!(
      company: company,
      customer: customer,
      amount: amount
    )
  end 
end 