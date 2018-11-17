class MonetizePurchases < ActiveRecord::Migration[5.2]
  def change
		add_monetize :purchases, :amount
  end
end
