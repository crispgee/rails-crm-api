class MembershipsController < ApplicationController
  before_action :set_membership, only: [:destroy]
  def create
    membership = Membership.find_or_create_by!(membership_params)
     render json: membership, staus: :created
    rescue ActiveRecord::RecordNotFound
     render json: {error: "Record not found"}, status: :not_found
  end 

  def destroy
    @membership.destroy
    head :no_content
  end 

  def membership_params
    params.require(:membership).permit(:customer_id, :company_id)
  end 
  def set_membership
    @membership = Membership.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Membership field is empty"}, status: :not_found
  end 
end
