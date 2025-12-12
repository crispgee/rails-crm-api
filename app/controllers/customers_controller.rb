class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update , :destroy , :add_company, :pay, :withdraw]
  def index
    render json: Customer.all
  end 

  def show 
    render json: @customer, serializer: CustomerSerializer
  end 

  def create
    new_customer = Customer.new(customer_params)
    if new_customer.save 
      render json: new_customer, status: :created
    else 
      render json: {errors: new_customer.errors.full_messages}, status: :unprocessable_entity
    end 
  end 

  def update
    if @customer.update(customer_params)
      render json: @customer,  status: :ok
    else 
      render json: {errors: @customer.errors.full_messages}, status: :unprocessable_entity
    end 
  end 

  def destroy
    @customer.destroy
    head :no_content
  end 

  def add_company
    company = Company.find(params[:company_id])
    @customer.companies << company unless @customer.companies.include?(company)
    render json: @customer, serializer: CustomerSerializer, status: :ok
  end 

  def pay 
    company = Company.find(params[:company_id])
    amount = params[:amount]
    PaymentCreator.create(
      company: company,
      customer: @customer,
      amount: amount
    )
    render json: @customer, serializer: CustomerSerializer, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {error: "No record found"}, status: :not_found
  end 

  def withdraw
    company = Company.find(params[:company_id])
    amount = params[:amount]
    WithdrawalCreator.create(
      company: company,
      customer: @customer,
      amount: amount
    )
    render json: @customer, serializer: CustomerSerializer, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {error: "No record found"}, status: :not_found
  end 

  private

  def set_customer
    @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Customer does not exist"}, status: :not_found
  end 

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :number)
  end 
end
