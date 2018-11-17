class AddNameToContractStyle < ActiveRecord::Migration[5.2]
  def change
  	add_column :contract_styles, :name, :string

  	ContractStyle.find_each do |contract_style|
  		case contract_style.lettercode
  		when 'D'
  			contract_style.update(name: 'Direct Award')
  		when 'P'
  			contract_style.update(name: 'Public Tender')
  		when 'I'
  			contract_style.update(name: 'Invitational Tender')
  		end
  	end
  end
end
