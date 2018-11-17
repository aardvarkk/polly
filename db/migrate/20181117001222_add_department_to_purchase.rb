class AddDepartmentToPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_reference :purchases, :department
  end
end
