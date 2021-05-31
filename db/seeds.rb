# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "kuro"
email = "kuro@gmail.com"
password = "111111"
User.create!(name: name,
             email: email,
             password:  "111111",
             password_confirmation: "111111",
             admin: true)
Label.create!([{ name: 'No1' },
              { name: 'No2' },
              { name: 'No3'},
              { name: 'No4'},
              { name: 'No5'},
              { name: 'No6'},
              { name: 'No7'},
              { name: 'No8'},
              { name: 'No9'},
              { name: 'No10'}
              ])
