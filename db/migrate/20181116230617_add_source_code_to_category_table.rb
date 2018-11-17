class AddSourceCodeToCategoryTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :source_code_mappings do |t|
  		t.references :source, foreign_key: true
  		t.references :code, foreign_key: true
  		t.references :category, foreign_key: true
  	end

		add_index :source_code_mappings, [:source, :code], :unique => true
  end
end
