# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Source.find_or_create_by!(
	name: 'Contract Registry'
)

Code.find_or_create_by!(
	name: 'ABC123',
	source: Source.first
)

Department.find_or_create_by!(
	name: 'My Department'
)

all = Category.find_or_initialize_by(
	name: 'All',
	parent: nil
)
all.save(validate: false)

all.children.find_or_create_by!(
	name: 'Goods'
)

all.children.find_or_create_by!(
	name: 'Services'
)
