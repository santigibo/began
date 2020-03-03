require 'open-uri'
require 'nokogiri'

User.destroy_all
Recipe.destroy_all
Challenge.destroy_all
Category.destroy_all

flexitarian = Category.create({name: 'flexitarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegetarian = Category.create({name: 'vegetarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegan = Category.create({name: 'vegan', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})

user1 = User.create({first_name: 'Santiago', last_name: 'Giraldo', age: 20, email:'santi@web.com', password: '123456'})
user1 = User.create({first_name: 'Félix', last_name: 'Timmel', age: 23, email:'felix@web.com', password: '123456'})

n = Challenge.count + 1
challenge1_flexi = Challenge.create({category: flexitarian, name: 'Tofu Beginner', description: 'Testing Tofu : Your challenge is to cook tofu !', position: n})
challenge2_flexi = Challenge.create({category: flexitarian, name: 'Proteiiins', description: 'First step replacing meet : Your challenge is to go for a full day without eating any meet !', position: n})
challenge3_flexi = Challenge.create({category: flexitarian, name: 'Tempe Lover', description: 'Testing Tempe : Your challenge is to cook tempe !', position: n})

tip1 = Tip.new(
                title: 'Do you really know your proteins ?',
                description: "Proteins are essentials to the good mechanism of our body. From our muscles to our skin to our hormones, proteins make our body work and regenerate itself. There 2 types of proteins: the essentials, that we find in food and the non-essentials that our body produce.
So what do you do when you don’t want to eat meat anymore ?
You eat green proteins !
Plant based proteins are as nutritious as meat if you know which one to eat and how to have a diverse diet. Plus green proteins are poor in fat, rich in fiber and vitamins, which is everything we need ! To be in good health, most organizations recommend to eat 0.8g of proteins per kilogram of body weight. This roughly equals to 46 grams of proteins for a woman or 56 grams for a man per day. (https://www.health.harvard.edu/blog/how-much-protein-do-you-need-every-day-201506188096)
Harvard protein calculator:"
              )
tip1.challenge = challenge2_flexi
tip1.save
# https://www.bbcgoodfood.com/search/recipes?query=#path=diet/vegetarian
# https://www.bbcgoodfood.com/search/recipes?query=tofu#query=tofu&path=diet/vegetarian

def scraping
  url = "https://www.bbcgoodfood.com/search/recipes?query=#path=diet/vegetarian"
  html = open("bbc.html").read
  html_doc = Nokogiri::HTML(html)
  reci = html_doc.search(".node-teaser-item").first(10).map do |element|
    photo_class = element.search(".teaser-item__image")
    photo_a = photo_class.search("img")
    photo_url = "https://" + photo_a.attribute("src").text[2..-1]
    file = URI.open(photo_url)
    name = element.search(".teaser-item__title").text.strip
    description = element.search(".field-items").text.strip
    prep_time = element.search(".teaser-item__info-item--total-time").text.strip
    difficulty = element.search(".teaser-item__info-item--skill-level").text.strip

    r = Recipe.new(name: name, description: description, time: prep_time, difficulty: difficulty)

    # c=Cloudinary::Uploader.upload(photo_url)
    begin
      r.photo.attach(io: file, filename: "#{name}.jpg", content_type: 'image/jpg')
      r.save
    rescue ActiveStorage::IntegrityError
      "Bad url: #{photo_url}"
    end
  end
  return reci
end

scraping()







# def scratch_top6(ingredient)
#   url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
#   html = open(url).read
#   html_doc = Nokogiri::HTML(html)
#   recip = html_doc.search(".node-teaser-item").first(6).map do |element|
#     photo_class = element.search(".teaser-item__image").text.strip
#     photo = element.attribute("src")
#     name = element.search(".teaser-item__title").text.strip
#     description = element.search(".field-items").text.strip
#     prep_time = element.search(".teaser-item__info-item--total-time").text.strip
#     difficulty = element.search(".teaser-item__info-item--skill-level").text.strip

#     Recipe.create(photo: photo, name: name, description: description, time: prep_time, difficulty: difficulty)
#   end
#   return recip
# end
