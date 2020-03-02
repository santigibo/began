# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Recipe.destroy_all
Challenge.destroy_all
Category.destroy_all

flexi = Category.create({name: 'flexitarian', descritption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegy = Category.create({name: 'vegetarian', descritption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegan = Category.create({name: 'vegan', descritption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})

user1 = User.create({first_name: 'Santiago', last_name: 'Giraldo', age: 20, email:'santi@web.com', password: '123456'})
user1 = User.create({first_name: 'Félix', last_name: 'Timmel', age: 23, email:'felix@web.com', password: '123456'})

n = Challenge.count + 1
challenge1_flexi = Challenge.create({category: flexi, name: 'Tofu Beginner', descritption: 'Testing Tofu : Your challenge is to cook tofu !', position: n})

