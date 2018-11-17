class CategoriesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Category.all.order(:name) }
		end
  end
end
