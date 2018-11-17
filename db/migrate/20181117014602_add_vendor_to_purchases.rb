class AddVendorToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :vendor, :reference
  end
end
