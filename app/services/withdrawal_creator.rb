class WithdrawalCreator 
  def self.create(company:, customer:, amount:)
      Withdrawal.create!(
        company: company,
        customer: customer,
        amount: amount
      )
  end 
end 