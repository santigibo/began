require 'open-uri'
require 'nokogiri'

Question.destroy_all
Answer.destroy_all
ChallengeCompletion.destroy_all
ChallengeRecipe.destroy_all
UserRecipe.destroy_all
User.destroy_all
RecipeMethod.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
Challenge.destroy_all
Category.destroy_all

def scrape_from(url)
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  photo_class = html_doc.search(".img-container")
  photo_a = photo_class.search("img")
  photo_url = "https://" + photo_a.attribute("src").text[2..-1]
  file = URI.open(photo_url)

  name = html_doc.search(".recipe-header__title").text.strip
  prep_time = html_doc.search(".recipe-details__cooking-time-prep span").text.strip
  difficulty = html_doc.search(".recipe-details__item--skill-level span").text.strip
  description = html_doc.search(".field-item p").text.strip

  r = Recipe.new(name: name, description: description, time: prep_time, difficulty: difficulty)

  unless Recipe.all.include?(r)
    begin
      r.photo.attach(io: file, filename: "#{name}.jpg", content_type: 'image/jpg')
      r.save
    rescue ActiveStorage::IntegrityError
      "Bad url: #{photo_url}"
    end
  end
  if r.persisted?
    ingredients = html_doc.search(".ingredients-list__item").each do |ingredient|
      ing = Ingredient.create(content: ingredient.attribute('content').value, recipe: r)
    end

    recipe_methods = html_doc.search('.method__list li p').each do |method|
      met = RecipeMethod.create(content: method.text.strip, recipe: r)
    end

    return r
  else
    return nil
  end
end

def scratch_top6(ingredient)
  url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  search_result = []
  recip = html_doc.search(".node-teaser-item").first(6).map do |element|
    unless element.nil?
      href = element.search(".teaser-item__title a").attribute('href').value
      reci_url = "https://www.bbcgoodfood.com#{href}"

      search_result << scrape_from(reci_url)
    end
  end
  return search_result.filter { |r| r }
end

flexitarian = Category.create({name: 'flexitarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegetarian = Category.create({name: 'vegetarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegan = Category.create({name: 'vegan', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})

user1 = User.create({first_name: 'Santiago', last_name: 'Giraldo', age: 20, email:'santi@web.com', password: '123456'})
user1 = User.create({first_name: 'Félix', last_name: 'Timmel', age: 23, email:'felix@web.com', password: '123456'})

challenge1_flexi = Challenge.create({category: flexitarian, name: 'Tofu Beginner', description: 'Testing Tofu : Your challenge is to cook tofu !', position: Challenge.count + 1})
scratch_top6('tofu').each do |recipe|
  challenge1_flexi.recipes << recipe
end

challenge2_flexi = Challenge.create({category: flexitarian, name: 'Proteiiins', description: 'First step replacing meet : Your challenge is to go for a full day without eating any meet !', position: Challenge.count + 1})

challenge3_flexi = Challenge.create({category: flexitarian, name: 'Tempeh Lover', description: 'Testing Tempe : Your challenge is to cook tempe !', position: Challenge.count + 1})
scratch_top6('tempeh').each do |recipe|
  challenge3_flexi.recipes << recipe
end

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
  reci = html_doc.search(".node-teaser-item").first(2).map do |element|
    href = element.search(".teaser-item__title a").attribute('href').value
    reci_url = "https://www.bbcgoodfood.com#{href}"

    scrape_from(reci_url)
  end
  return reci
end

scraping()

#QUIZZ PART
question1_chall1 = Question.new(content:"What is tofu made of ?")
question1_chall1.challenge = challenge1_flexi
question1_chall1.save

answer1_q1_c1 = Answer.new(
                            content:"Tofu is made from soybeans",
                            status: true,
                            explanation:"Right ! bla bla bla bla "
                          )
answer1_q1_c1.question = question1_chall1
answer1_q1_c1.save


answer2_q1_c1 = Answer.new(
                            content:"Tofu is made from cheese",
                            status: false,
                            explanation:"False ! bla bla bla bla "
                          )
answer2_q1_c1.question = question1_chall1
answer2_q1_c1.save


answer2_q1_c1 = Answer.new(
                            content:"Tofu is made from almond milk",
                            status: false,
                            explanation:"False ! bla blou bla bla bla "
                          )
answer2_q1_c1.question = question1_chall1
answer2_q1_c1.save

# --------------------------------------------

question2_chall1 = Question.new(content:"Where is tofu coming from ?")
question2_chall1.challenge = challenge1_flexi
question2_chall1.save

answer2_q2_c1 = Answer.new(
                            content:"America",
                            status: false,
                            explanation:"False ! It's coming from China ! "
                          )
answer2_q2_c1.question = question2_chall1
answer2_q2_c1.save

answer2_q2_c1 = Answer.new(
                            content:"China",
                            status: true,
                            explanation:"Excellent !"
                          )
answer2_q2_c1.question = question2_chall1
answer2_q2_c1.save

answer2_q2_c1 = Answer.new(
                            content:"Argentina",
                            status: false,
                            explanation:"False ! It's coming from China ! "
                          )
answer2_q2_c1.question = question2_chall1
answer2_q2_c1.save

# --------------------------------------------

question3_chall1 = Question.new(content:"Can you have tofu for dessert ?")
question3_chall1.challenge = challenge1_flexi
question3_chall1.save

answer1_q3_c1 = Answer.new(
                            content:"Yes, tofu can be sweet",
                            status: true,
                            explanation:"Of course ! (look at our tofu recepies :)"
                          )
answer1_q3_c1.question = question3_chall1
answer1_q3_c1.save

answer2_q3_c1 = Answer.new(
                            content:"No, tofu is only prepared has a salty meal.",
                            status: false,
                            explanation:"Of course it can ! (look at our tofu recepies :)"
                          )
answer2_q3_c1.question = question3_chall1
answer2_q3_c1.save
