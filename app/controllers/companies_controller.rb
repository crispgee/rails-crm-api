class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update , :destroy, :balance]

  def index 
    render json: Company.all
  end 

  def show 
    render json: @company 
  end 

  def create 
    company = Company.new(company_params)
    if company.save
      render json: company, status: :created
    else 
      render json: {error: comapany.errors.full_messages}, staus: :unprocessable_entity
    end 
  end 

  def update
    if @company.update(company_params)
      render json: @student, status: :ok
    else 
      render json: {error: @company.errors.full_messages}, status: :unprocessable_entity
    end 
  end 

  def destroy
    @company.destroy
    haed :no_content
  end 

  def balance 
    render json: {balance: @company.balance}
  end 

  def customer_companies
    customer = Customer.find(params[:customer_id])
    render json: customer.companies 
  end 

  private
  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Company does not exist"}, status: :not_found
  end 

  def company_params
    params.require(:company).permit(:name, :industry, :registration_number)
  end 
end
