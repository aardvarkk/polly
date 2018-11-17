class AddPurchasedOnToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :purchased_on, :date
    change_column :purchases, :purchased_on, :date, null: false
  end
end
