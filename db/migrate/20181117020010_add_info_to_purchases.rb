class AddInfoToPurchases < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :contract_number, :string
  	add_column :purchases, :order_number, :integer
  	add_column :purchases, :fiscal_year, :integer
  	add_reference :purchases, :location
  	add_reference :purchases, :contract_style
  end
end
