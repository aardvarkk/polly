class VendorsController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Vendor.all }
		end
  end
end
