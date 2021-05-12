# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name:"John", last_name:"Adam", email:"John@Adam.com",password:"password",access_right_enum: 1)

User.create(first_name:"Chris", last_name:"Bob", email:"Chris@Bob.com",password:"password",access_right_enum: 2)

Product.create(name:"product1", description:"product1", unit_price:10.00)
Product.create(name:"product2", description:"product2", unit_price:20.00)
Product.create(name:"product3", description:"product3", unit_price:30.00)
Product.create(name:"product4", description:"product4", unit_price:40.00)
Product.create(name:"product5", description:"product5", unit_price:50.00)
Product.create(name:"product6", description:"product6", unit_price:60.00)
Product.create(name:"product7", description:"product7", unit_price:70.00)
Product.create(name:"product8", description:"product8", unit_price:80.00)
Product.create(name:"product9", description:"product9", unit_price:90.00)
Product.create(name:"product10", description:"product10", unit_price:100.00)


