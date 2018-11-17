class LocationsController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Location.all.order(:name) }
		end
  end
end
