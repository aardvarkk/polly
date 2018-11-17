class AddYukonToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :yukon, :boolean
  end
end
