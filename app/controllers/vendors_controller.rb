class VendorsController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Vendor.all.order(:name) }
		end
  end
end
