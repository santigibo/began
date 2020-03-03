require 'open-uri'
require 'nokogiri'

User.destroy_all
Recipe.destroy_all
Challenge.destroy_all
Category.destroy_all

flexi = Category.create({name: 'flexitarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegy = Category.create({name: 'vegetarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegan = Category.create({name: 'vegan', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})

user1 = User.create({first_name: 'Santiago', last_name: 'Giraldo', age: 20, email:'santi@web.com', password: '123456'})
user1 = User.create({first_name: 'Félix', last_name: 'Timmel', age: 23, email:'felix@web.com', password: '123456'})

n = Challenge.count + 1
challenge1_flexi = Challenge.create({category: flexi, name: 'Tofu Beginner', description: 'Testing Tofu : Your challenge is to cook tofu !', position: n})

# https://www.bbcgoodfood.com/search/recipes?query=#path=diet/vegetarian
# https://www.bbcgoodfood.com/search/recipes?query=tofu#query=tofu&path=diet/vegetarian

def scratch
  url = "https://www.bbcgoodfood.com/search/recipes?query=#path=diet/vegetarian"
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  reci = html_doc.search(".node-teaser-item").first(10).map do |element|
    name = element.search(".teaser-item__title").text.strip
    description = element.search(".field-items").text.strip
    prep_time = element.search(".teaser-item__info-item--total-time").text.strip
    difficulty = element.search(".teaser-item__info-item--skill-level").text.strip

    Recipe.create(name: name, description: description, time: prep_time, difficulty: difficulty)
  end
  return reci
end

def scratch_top6(ingredient)
  url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  recip = html_doc.search(".node-teaser-item").first(6).map do |element|
    name = element.search(".teaser-item__title").text.strip
    description = element.search(".field-items").text.strip
    prep_time = element.search(".teaser-item__info-item--total-time").text.strip
    difficulty = element.search(".teaser-item__info-item--skill-level").text.strip

    Recipe.create(name: name, description: description, time: prep_time, difficulty: difficulty)
  end
  return recip
end
