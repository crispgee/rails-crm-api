class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show]

  def index
    render json: Payment.all 
  end 

  def show
    render json: @payment 
  end 

  def create 
    payment = Payment.new(payment_params)
    if payment.save
      render json: payment, include: [:customer, :company], status: :created
    else 
      render json: {error: payment.errors}, status: :unprocessable_entity
    end 
  end 

  def customer_payments
    customer = Customer.find(params[:customer_id])
    render json: customer.payments
  end 

  def company_payments
    company = Company.find(params[:company_id])
    render json: company.payments
  end 


  private
  def payment_params
    params.require(:payment).permit(:amount, :currency, :customer_id, :company_id)
  end 

  def set_payment
    @payment = Payment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Record does not exist"}, status: :not_found
  end 
  
end
