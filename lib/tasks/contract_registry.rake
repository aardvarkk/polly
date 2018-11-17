namespace :contract_registry do
  desc "Set whether each purchase is inside or outside the Yukon"
  task :set_in_yukon, [:filename] => :environment do |task, args|
    outside_ids = Location.where(name: [
      'Other',
      'Other-Non Yukon',
      'Out of Territory'
    ]).ids
    Purchase.where(location_id: outside_ids).update_all(yukon: false)
    Purchase.where.not(location_id: outside_ids).update_all(yukon: true)
  end

  desc "Assign categories for contract registry codes"
  task :assign_categories, [:filename] => :environment do |task, args|
    all = Category.first

     # Hospitality
    hospitality = Category.find_or_create_by!(name: 'Hospitality', parent: all)
    Code.where(name: 'Accomodation').update(category: hospitality)
    Code.where(name: 'Housing, accommodation, hotels').update(category: hospitality)

     # Finance
    finance = Category.find_or_create_by!(name: 'Finance', parent: all)
    Code.where(name: 'Actuarial, Accounting, Financial Services').update(category: finance)

    # Tourism & Culture
    tourcult = Category.find_or_create_by!(name: 'Tourism & Culture', parent: all)
    Code.where(name: 'Advertising').update(category: tourcult)
    Code.where(name: 'Photographic services').update(category: tourcult)

    # Services
    service = Category.find_or_create_by!(name: 'Service', parent: all)
    Code.where(name: 'Air Charter').update(category: service)
    Code.where(name: 'Aircraft Charter').update(category: service)
    Code.where(name: 'Mapping services').update(category: service)
    Code.where(name: 'Printing services').update(category: service)
    Code.where(name: 'Service').update(category: service)
    Code.where(name: 'Service Contracts - Accomodation').update(category: service)
    Code.where(name: 'Service Contracts - Aircraft Charters').update(category: service)
    Code.where(name: 'Service Contracts - Equipment Rentals').update(category: service)
    Code.where(name: 'Service Contracts - General').update(category: service)
    Code.where(name: '').update(category: service)

    # Engineering/Arch
    engarch = Category.find_or_create_by!(name: 'Engineering/Architectural', parent: all)
    Code.where(name: 'Architect Services').update(category: engarch)
    Code.where(name: 'Engineering/Architectural').update(category: engarch)
    Code.where(name: 'Engineering Services').update(category: engarch)

    # Environment
    environ = Category.find_or_create_by!(name: 'Environment', parent: all)
    Code.where(name: 'Environmental Services/ studies').update(category: environ)

    # Lease/Rent
    lease = Category.find_or_create_by!(name: 'Lease/Rent', parent: all)
    Code.where(name: 'Equipment Rental').update(category: lease)
    Code.where(name: 'Leased Office Space').update(category: lease)
    Code.where(name: 'Lease or Rental of heavy equipment').update(category: lease)
    Code.where(name: 'Lease or Rental of light duty vehicle').update(category: lease)
    Code.where(name: 'Real Estate Leases').update(category: lease)
    Code.where(name: 'Real Property Lease').update(category: lease)
    Code.where(name: 'Service Contracts - Vehicle Leases').update(category: lease)
    Code.where(name: 'Vehicle Rental').update(category: lease)

    # Other
    other = Category.find_or_create_by!(name: 'Other', parent: all)
    Code.where(name: 'Freight - transport - courier services').update(category: other)
    Code.where(name: 'Memberships').update(category: other)

    # IT
    it = Category.find_or_create_by!(name: 'IT', parent: all)
    Code.where(name: 'IT System Development').update(category: it)
    Code.where(name: 'IT System Mantenance').update(category: it)

    # Community Services
    commserv = Category.find_or_create_by!(name: 'Community Services', parent: all)
    Code.where(name: 'Landscaping').update(category: commserv)
    Code.where(name: 'Snow removal').update(category: commserv)

    # Health & Social
    health = Category.find_or_create_by!(name: 'Health & Social', parent: all)
    Code.where(name: 'Physician Services under ACT').update(category: health)
    Code.where(name: 'Health Services except physician services under ACT').update(category: health)

    # Consulting
    consult = Category.find_or_create_by!(name: 'Consulting', parent: all)
    Code.where(name: 'General Consulting').update(category: consult)
    Code.where(name: 'General consulting services').update(category: consult)
    Code.where(name: 'Consulting Contracts - Engineering / Architectural').update(category: consult)
    Code.where(name: 'Consulting Contracts - General').update(category: consult)

    # Construction
    construct = Category.find_or_create_by!(name: 'Construction', parent: all)
    Code.where(name: 'Construction').update(category: construct)
    Code.where(name: 'Construction - building maintenance').update(category: construct)
    Code.where(name: 'Construction - building new').update(category: construct)
    Code.where(name: 'Construction Contracts').update(category: construct)
    Code.where(name: 'Construction - road').update(category: construct)
    Code.where(name: 'Construction - utilities / infrastructure maintenance').update(category: construct)
    Code.where(name: 'Construction - utilities / infrastructure new').update(category: construct)

    # Public Relations
    pr = Category.find_or_create_by!(name: 'Public Relations', parent: all)
    Code.where(name: 'Communications/public relations Services').update(category: pr)

    # Education & Research
    edu = Category.find_or_create_by!(name: 'Education & Research', parent: all)
    Code.where(name: 'Education related services').update(category: edu)
    Code.where(name: 'Research and Development').update(category: edu)

    # HR/Employment etc
    hr = Category.find_or_create_by!(name: 'HR, Employment etc', parent: all)
    Code.where(name: 'Employment').update(category: hr)
    Code.where(name: 'Relocation services').update(category: hr)
    Code.where(name: 'Training delivery').update(category: hr)

  end

  desc "Insert data from a contract registry CSV file"
  task :from_csv, [:filename] => :environment do |task, args|
  	require 'csv'
    Money.locale_backend = :currency

  	CSV.foreach(args[:filename], {headers: true}) do |row|
  		# p row

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
      amount = Money.new((row['Amount'].gsub(/[\D\.]/,'').to_f * 100).to_i, 'CAD')
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
