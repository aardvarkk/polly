namespace :fake do
  desc "Insert a bunch of fake purchases"
  task :data, [:count] => :environment do |task, args|
		require 'faker'
		Money.locale_backend = :currency

  	args[:count].to_i.times do
  		source = Source.all.sample
  		Purchase.create!(
  			code: source.codes.sample,
  			department: Department.all.sample,
  			description: Faker::Commerce.product_name,
  			purchased_on: Faker::Date.backward(3650),
  			amount: Money.new(rand * 200000 - 10000, 'CAD')
  		)
  	end
  end
end
