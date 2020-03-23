require 'open-uri'
require 'nokogiri'

NoMeatDay.destroy_all
Comment.destroy_all
Post.destroy_all
QuestionCompletion.destroy_all
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
  return nil if name == "Tofu & spinach cannelloni"
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

      r = scrape_from(reci_url)

      unless r.nil?
        search_result << r
      end
    end
  end
  return search_result.filter { |r| r }
end

def scraping
  url = "https://www.bbcgoodfood.com/search/recipes?query=#path=diet/vegetarian"
  html = open("bbc.html").read
  html_doc = Nokogiri::HTML(html)
  reci = html_doc.search(".node-teaser-item").first(10).map do |element|
    href = element.search(".teaser-item__title a").attribute('href').value
    reci_url = "https://www.bbcgoodfood.com#{href}"

    scrape_from(reci_url)
  end
  return reci
end


puts "-------------------------------------------------------------------------------------------------------------------"


puts "Create the three categories of the app: felxitarian, vegetarian and vegan"
flexitarian = Category.create({name: 'flexitarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegetarian = Category.create({name: 'vegetarian', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})
vegan = Category.create({name: 'vegan', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo deserunt asperiores facere labore, voluptatibus, maxime quae nesciunt ipsam, laborum laudantium qui quam? Rerum quam nemo, necessitatibus, enim adipisci perspiciatis rem.'})


puts "-------------------------------------------------------------------------------------------------------------------"


puts "Create 4 users"
User.create({first_name: 'Santiago', last_name: 'Giraldo', email:'santi@web.com', password: '123456'})
User.create({first_name: 'Vicky', last_name: 'Andre', email:'vicky@web.com', password: '123456'})
User.create({first_name: 'Katell', last_name: 'Goaer', email:'katell@web.com', password: '123456'})
User.create({first_name: 'Félix', last_name: 'Timmel', email:'felix@web.com', password: '123456'})

puts "-------------------------------------------------------------------------------------------------------------------"

puts "Create challenges for flexitarian"

puts "-------------------------------------------------------------------------------------------------------------------"

puts "FIRST CHALLENGE FLEXETARIAN"
challenge1_flexi = Challenge.create(category: flexitarian, name: 'Meet tofu', description: 'Buy a piece of tofu. Read the tips for more information!', position: flexitarian.challenges.count + 1)


    puts "Create tips for the first flexetarian challenge"
    tip1_flexi_c1 = Tip.new(title: "Clear ingredients",
                           description: "Avoid fake tofus with GMO’s and other chemicals. Always take
                                         30 seconds to read the label. It should be straight with the
                                         ingredients: fermented soybeans and coagulant (a type of salt
                                         either calcium chloride, calcium sulfate or magnesium sulfate)")
    tip1_flexi_c1.challenge = challenge1_flexi
    tip1_flexi_c1.save

    tip2_flexi_c1 = Tip.new(title: "Amorphus",
                           description: "Silken to use it as cream cheese; regular for stews or noodle soups;
                                        firm to pan-dry it. There is a lot of types of tofu, and each one can be
                                        used for different recipes.")
    tip2_flexi_c1.challenge = challenge1_flexi
    tip2_flexi_c1.save

    tip3_flexi_c1 = Tip.new(title: "Where",
                           description: "In every supermarket you can find blocks of tofu. The firm is the one
                                        most widely available in supermakets, but don't hesitate on looking
                                        for different types. Remember the first tip and look for the most natural
                                          one, avoid chemicals.")
    tip3_flexi_c1.challenge = challenge1_flexi
    tip3_flexi_c1.save

puts "-------------------------------------------------------------------------------------------------------------------"

puts "SECOND CHALLENGE FLEXETARIAN"
challenge2_flexi = Challenge.create(category: flexitarian, name: 'Cook tofu', description: 'Look into recipes for tofu and cook something! There is a lot of possibilites, just try one', position: flexitarian.challenges.count + 1)

puts "Adding special recipes for the second challenge"
scratch_top6('tofu').each do |recipe|
  challenge2_flexi.recipes << recipe
end

    tip1_flexi_c2 = Tip.new(title: 'History',
                           description: "Made from fermented soybean milk, Tofu is also called “bean curd”
                                because of its silky, cheese-like texture. Originated from ancient
                                China, tofu is probably the most popular substitute for meat because
                                it's high in protein and amino acids."
                  )
    tip1_flexi_c2.challenge = challenge2_flexi
    tip1_flexi_c2.save


    tip2_flexi_c2 = Tip.new(title: "No haters",
                           description: "Most people will tell you that tofu is tasteless. Don’t listen
                                        to them ! If they say so, it probably means that they never cook
                                        it !")
    tip2_flexi_c2.challenge = challenge2_flexi
    tip2_flexi_c2.save

puts "-------------------------------------------------------------------------------------------------------------------"

puts "THIRD CHALLENGE FLEXETARIAN"
challenge3_flexi = Challenge.create(category: flexitarian, name: 'Tofu quizz', description: 'Answer the questions of the quizz.', is_quizz: true, position: flexitarian.challenges.count + 1)


  puts "CREATE THE QUIZ FOR THE THIRD CHALLENGE"

    puts "Create the first question for the first challenge of flexetarian"
    question1_c3 = Question.new(content:"What is tofu made of?")
    question1_c3.challenge = challenge3_flexi
    question1_c3.save

      puts "Answers for question 1 of challenge 3"
      answer1_q1_c3 = Answer.new(
                                  content: "Tofu is made from soybeans",
                                  status: true,
                                  explanation: "Yes, that’s right. Remember, straightforward with the ingredients: fermented soybeans and coagulant. Avoid fakers."
                                )
      answer1_q1_c3.question = question1_c3
      answer1_q1_c3.save


      answer2_q1_c3 = Answer.new(
                                  content:"Tofu is made from cheese",
                                  status: false,
                                  explanation:"It looks like, but not exactly. Keep looking."
                                )
      answer2_q1_c3.question = question1_c3
      answer2_q1_c3.save


      answer3_q1_c3 = Answer.new(
                                  content:"Tofu is made from almond milk",
                                  status: false,
                                  explanation:"It would be awesome, but not the case. A little bit different."
                                )
      answer3_q1_c3.question = question1_c3
      answer3_q1_c3.save

    puts "Create the second question for the first challenge of flexetarian"
    question2_c3 = Question.new(content:"Where does tofu come from?")
    question2_c3.challenge = challenge3_flexi
    question2_c3.save

      puts "Answers for question 2 of challenge 3"
      answer1_q2_c3 = Answer.new(
                                  content: "Tofu comes from America",
                                  status: false,
                                  explanation: "You are just half a world far from the actual place, but good guess! Keep looking"
                                )
      answer1_q2_c3.question = question2_c3
      answer1_q2_c3.save


      answer2_q2_c3 = Answer.new(
                                  content:"Tofu comes from China",
                                  status: true,
                                  explanation:"Yes. They made this awesome substitute possible. Thank you China"
                                )
      answer2_q2_c3.question = question2_c3
      answer2_q2_c3.save


      answer3_q2_c3 = Answer.new(
                                  content:"Tofu comes from Atlantis",
                                  status: false,
                                  explanation:"Come on, it was a tricky question. Keep looking."
                                )
      answer3_q2_c3.question = question2_c3
      answer3_q2_c3.save

    puts "Create the third question for the first challenge of flexetarian"
    question3_c3 = Question.new(content:"Can you have tofu for dessert?")
    question3_c3.challenge = challenge3_flexi
    question3_c3.save

      puts "Answers for question 3 of challenge 3"
      answer1_q3_c3 = Answer.new(
                                  content: "Yes",
                                  status: true,
                                  explanation: "There is a lot of possibilities for tofu, and you can create more.
                                                Try looking for some tofu dessert recipes, they are really good"
                                )
      answer1_q3_c3.question = question3_c3
      answer1_q3_c3.save


      answer2_q3_c3 = Answer.new(
                                  content:"No",
                                  status: false,
                                  explanation:"Actually it’s a really good possibility and is delicious. Try it."
                                )
      answer2_q3_c3.question = question3_c3
      answer2_q3_c3.save


puts "-------------------------------------------------------------------------------------------------------------------"


puts "FOURTH CHALLENGE FLEXETARIAN"
challenge4_flexi = Challenge.create(category: flexitarian, name: 'Meet Quinoa',
                                    description: 'Buy a type of quinoa and cook something. Choeck out the recipes for the challenge',
                                    position: flexitarian.challenges.count + 1)
puts "Adding special recipes for the fourth challenge"
scratch_top6('quinoa vegetarian').each do |recipe|
  challenge4_flexi.recipes << recipe
end


  puts "Create tips for the fourth flexetarian challenge"
  tip1_flexi_c4 = Tip.new(title: 'History',
                         description: "Cultivated for more than 5000 years in South America
                                       (specifically Peru, Bolivia and Ecuador)")
  tip1_flexi_c4.challenge = challenge4_flexi
  tip1_flexi_c4.save

  tip2_flexi_c4 = Tip.new(title: "Is a complete protein",
                         description: "It means that it contains the 9 amino acids the human
                                       body needs for growth and tissue regeneration. there is
                                       8g of proteins for every 100g of quinoa, a perfect number.")
  tip2_flexi_c4.challenge = challenge4_flexi
  tip2_flexi_c4.save

  tip3_flexi_c4 = Tip.new(title: "Like rice",
                         description: "Quinoa is a plant that looks like a cereal. Relative to
                                       the spinach family, we actually eat the seeds that we cook
                                       in 15 minutes like rice.")
  tip3_flexi_c4.challenge = challenge4_flexi
  tip3_flexi_c4.save

  tip4_flexi_c4 = Tip.new(title: "When cooking",
                         description: "The quinoa grains are protected by a thin envelope that can
                                       be bitter. So even if most quinoa available today are sold
                                       already clean, take a few minutes to rinse it before cooking it.")
  tip4_flexi_c4.challenge = challenge4_flexi
  tip4_flexi_c4.save

puts "-------------------------------------------------------------------------------------------------------------------"

puts "FIFTH CHALLENGE FLEXETARIAN"
challenge5_flexi = Challenge.create(category: flexitarian, name: 'Quinoa 101',
                                    is_quizz: true,
                                    description: "Answer the quinoa quizz and let's see how much did you learned.",
                                    position: flexitarian.challenges.count + 1)


  puts "CREATE THE QUIZ FOR THE FIFTH CHALLENGE"

    puts "Create the first question for the fifth challenge of flexetarian"
    question1_c5 = Question.new(content:"There is only one kind of quinoa?")
    question1_c5.challenge = challenge5_flexi
    question1_c5.save

      puts "Answers for question 1 of challenge 5"
      answer1_q1_c5 = Answer.new(
                                  content: "Yes",
                                  status: false,
                                  explanation: "Remember about the colors and forms"
                                )
      answer1_q1_c5.question = question1_c5
      answer1_q1_c5.save


      answer2_q1_c5 = Answer.new(
                                  content:"No",
                                  status: true,
                                  explanation:"Over a 100 types of quinoa, lot’s of colors and flour, flakes and grain form. A lot of variety, a lot to choose."
                                )
      answer2_q1_c5.question = question1_c5
      answer2_q1_c5.save

    puts "Create the second question for the second challenge of flexetarian"
    question2_c5 = Question.new(content:"Where does quinoa comes from?")
    question2_c5.challenge = challenge5_flexi
    question2_c5.save

      puts "Answers for question 2 of challenge 5"
      answer1_q2_c5 = Answer.new(
                                  content: "Peru",
                                  status: true,
                                  explanation: "Yes. It has been cultivated for more than 5000 years in south america, specially in Peru, Bolivia and Ecuador"
                                )
      answer1_q2_c5.question = question2_c5
      answer1_q2_c5.save


      answer2_q2_c5 = Answer.new(
                                  content:"France",
                                  status: false,
                                  explanation:"It's a little bit far"
                                )
      answer2_q2_c5.question = question2_c5
      answer2_q2_c5.save


      answer3_q2_c5 = Answer.new(
                                  content:"Japan",
                                  status: false,
                                  explanation:"It's far"
                                )
      answer3_q2_c5.question = question2_c5
      answer3_q2_c5.save

    puts "Create the third question for the second challenge of flexetarian"
    question3_c5 = Question.new(content:"How many grams of protein is there in a 100g of quinoa?")
    question3_c5.challenge = challenge5_flexi
    question3_c5.save

      puts "Answers for question 3 of challenge 5"
      answer1_q3_c5 = Answer.new(
                                  content: "1g",
                                  status: false,
                                  explanation: "Come on. That’s a small number for 100g of delicious quinoa"
                                )
      answer1_q3_c5.question = question3_c5
      answer1_q3_c5.save


      answer2_q3_c5 = Answer.new(
                                  content:"8g",
                                  status: true,
                                  explanation:"Perfect 8% of protein. On the other hand, it has a lot of
                                               fiber, that is really good for your body."
                                )
      answer2_q3_c5.question = question3_c5
      answer2_q3_c5.save

      answer3_q3_c5 = Answer.new(
                                  content:"20g",
                                  status: false,
                                  explanation:"Wow. Chill"
                                )
      answer3_q3_c5.question = question3_c5
      answer3_q3_c5.save

puts "-------------------------------------------------------------------------------------------------------------------"

puts 'Adding recipes to all the list'
scraping()

puts 'Seed finished'
