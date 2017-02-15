class CatRentalRequestsController < ApplicationController

  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(rental_params)
    if @request.save
      redirect_to cat_url(id: @request.cat_id)
    else
      redirect cat_rental_request_url
    end
  end

  def approve
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.approve!
    redirect_to cat_url(id: @request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.deny!
    redirect_to cat_url(id: @request.cat_id)
  end

  private

  def rental_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end
end
