class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :name
      t.references :source, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
