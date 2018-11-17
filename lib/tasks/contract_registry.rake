namespace :contract_registry do
  desc "Insert data from a contract registry CSV file"
  task :from_csv, [:filename] => :environment do |task, args|
  	require 'csv'
    Money.locale_backend = :currency

  	CSV.foreach(args[:filename], {headers: true}) do |row|
  		p row

  		order_number = begin
  			Integer(row['C.O. No.'])
  		rescue
  			0
  		end

  		source = Source.find_or_create_by!(name: 'Contract Registry')
  		code = Code.find_or_create_by!(name: row['Contract Type'], source: source)
  		vendor = Vendor.find_or_create_by!(name: row['Vendor Name'])
  		department = Department.find_or_create_by!(name: row['Department'])
  		location = Location.find_or_create_by!(name: row['Community'])
  		contract_style = ContractStyle.find_or_create_by!(lettercode: row['Type'])
  		fiscal_year = row['Fiscal Year'].match(/\d{4}/)[0]
  		amount = Money.new(row['Amount'], 'CAD')
  		purchased_on = Date.parse(row['Start Date'])

  		purchase = Purchase.find_or_initialize_by(
  			contract_number: row['Contract No.'],
  			order_number: order_number,
  		)
  		purchase.update(
  			description: row['Contract Description'],
  			code: code,
  			vendor: vendor,
  			amount: amount,
  			purchased_on: purchased_on,
  			department: department,
  			location: location,
  			contract_style: contract_style,
  			fiscal_year: fiscal_year
  		)
  		purchase.save

  		# break
  	end
  end

end
