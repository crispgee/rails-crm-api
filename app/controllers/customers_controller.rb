class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update , :destroy , :balance]
  def index
    render json: Customer.all
  end 

  def show 
    total_balance = @customer.balance

    render json: {
            customer: {
                 id: @customer.id,
                 name: @customer.first_name,
                 email: @customer.email
            },
            Balance: total_balance
  }
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

  def balance
    render json: {balance: @customer.balance}
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
