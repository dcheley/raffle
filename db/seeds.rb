# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{ email: "email@one.com", password: "123456", name:'Janet', admin: true},
            { email: "email@two.com", password: "123456", name:'Sally'},
            { email: "email@three.com", password: "123456", name:'Joe'},
            { email: "email@four.com", password: "123456", name:'Carol'},
            { email: "email@five.com", password: "123456", name:'Emily'}])

# Transaction.create([{ payee: "John", quantity: 5, debt: 20.20, email: "test@email.com", ministry: "MEDG" }])
