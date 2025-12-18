class WithdrawalsController < ApplicationController
  before_action :set_withdrawal, only: [:show]
  def index
    render json: Withdrawal.all 
  end 

  def show 
    render json: @withdrawal
  end 

  def create
    withdraw = Withdrawal.new(withdrawal_params)
    if withdraw.save
      Withdrawal.requested_at = Time.now
      render json: withdraw, include: [:company, :customer], status: :created
    else 
      render json: {error: "Withdrawal failed"}, status: :unprocessable_entity
    end 
  end 

  def company_withdrawals
    company = Company.find(params[:company_id])
    render json: company.withdrawals
  end

  def customer_withdrawals
    customer = Customer.find(params[:customer_id])
    render json: customer.withdrawals
  end 

  private
  def withdrawal_params
    params.require(:withdrawal).permit(:amount, :customer_id, :company_id)
  end 
  def set_withdrawal
    @withdrawal = Withdrawal.find([params[:id]])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Record does not exist"}, status: :not_found
  end 

end
