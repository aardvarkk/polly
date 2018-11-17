class DepartmentsController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: Department.all }
		end
  end
end
