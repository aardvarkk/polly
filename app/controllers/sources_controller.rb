class SourcesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Source.all.order(:name) }
		end
  end
end
