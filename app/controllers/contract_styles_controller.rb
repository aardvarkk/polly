class ContractStylesController < ApplicationController
  def index
		respond_to do |format|
		  format.json { render json: ContractStyle.all }
		end
  end
end
