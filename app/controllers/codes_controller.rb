class CodesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Code.all.order(:name) }
		end
  end
end
