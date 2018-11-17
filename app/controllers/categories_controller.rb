class CategoriesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Category.all }
		end
  end
end
