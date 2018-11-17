class CodesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Code.all }
		end
  end
end
