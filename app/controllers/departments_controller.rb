class DepartmentsController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Department.all.order(:name) }
		end
  end
end
