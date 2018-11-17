class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.string :description
      t.references :code, foreign_key: true

      t.timestamps
    end
  end
end
