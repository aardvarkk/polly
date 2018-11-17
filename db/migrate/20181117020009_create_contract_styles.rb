class CreateContractStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :contract_styles do |t|
      t.string :lettercode

      t.timestamps
    end
  end
end
