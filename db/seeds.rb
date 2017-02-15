# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.destroy_all

c1 = Cat.create!(name: 'Bob', color: 'Black', sex: "M", birth_date: "2015/01/20", description: "i love this cat." )
c2 = Cat.create!(name: 'Alicia', color: 'White', sex: "F", birth_date: "2014/04/20", description: "i like this cat." )
c3 = Cat.create!(name: 'Mike', color: 'Purple', sex: "M", birth_date: "2010/04/08", description: "i hate this cat." )

CatRentalRequest.destroy_all

CatRentalRequest.create!(cat_id: c1.id, start_date: '2016/01/20', end_date: '2016/1/25', status: 'PENDING')
CatRentalRequest.create!(cat_id: c1.id, start_date: '2016/02/20', end_date: '2016/2/25', status: 'PENDING')
CatRentalRequest.create!(cat_id: c1.id, start_date: '2016/02/20', end_date: '2016/2/23', status: 'PENDING')
CatRentalRequest.create!(cat_id: c3.id, start_date: '2016/01/20', end_date: '2016/1/25', status: 'APPROVED')
