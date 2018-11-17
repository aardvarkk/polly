class AddPurchasedAtToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :purchased_at, :datetime
    change_column :purchases, :purchased_at, :datetime, null: false
  end
end
