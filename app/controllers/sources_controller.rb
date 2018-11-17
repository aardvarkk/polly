class SourcesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Source.all }
		end
  end
end
