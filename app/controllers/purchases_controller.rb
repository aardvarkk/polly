class PurchasesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Purchase.all }
		end
  end
end
