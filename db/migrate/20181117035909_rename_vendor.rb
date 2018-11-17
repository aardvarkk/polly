class RenameVendor < ActiveRecord::Migration[5.2]
  def change
  	rename_column :purchases, :vendor, :vendor_id
  	change_column :purchases, :vendor_id, :integer
  end
end
