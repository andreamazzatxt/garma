require 'json'
require 'open-uri'

puts 'Start seeding... 🤟'

olivia = User.new(
  email: 'olivia@gmail.com',
  password: 'password',
  first_name: 'Olivia',
  last_name: 'Smith',
  birthday: '21/11/1989'
  gender: 'female'
  )
picture = URI.open('https://cdn.nohat.cc/thumb/f/720/comrawpixel541200.jpg')
olivia.photo.attach(io: picture, filename: 'olivia.jpg', content_type: 'image/jpg')
olivia.save!

# GENERATE FABRICS INSTANCES

fabrics = JSON.parse(open('./scraped_data/fibers.json'))
fabrics.each do |fabric|
  Fabric.create!(
      name: fabric[:name].downcase,
      description: fabric[:description]
      rating: fabric[:is_sustainable] ? 1 : 0
    )
end

# BRANDS INSTANCES

brands = JSON.parse(open('./scraped_data/brands.json'))
brands.each do |brand|
  Brand.create!(
    name: brand[:name],
    rating: brand[:rating],
    planet_rating: brand[:subratings][:planet]
    people_rating: brand[:subratings][:people]
    animals_rating: brand[:subratings][:animals]
    planet_description: brand[:description][:planet]
    people_description: brand[:description][:people]
    animals_description: brand[:description][:animals]
    )
end

# HM PRODUCT INSTANCES
hm_products = JSON.parse(open('./scraped_data/hm_items.json'))

hm_products.each do |product|
  instance = Product.create!(
            name: product[:name],
            category: product[:article_type],
            article_number: product[:article_number],
            department: product[:department],
            photo_url: product[:img]
            brand: Brands.where(name: product[:brand])
            )
  product[:composition].each do |material|
      Used_material.create!(
                  percentage: material[:percentage],
                  fabric: Fabric.where(name: material[:fabric].downcase)
                  )
  if product[:suppliers][:exist?]
    product[:suppliers][:list].each do |supplier|
      current = Supplier.create!(
          name: supplier[:name],
          country: supplier[:country],
          addresses: supplier[:address]
        )
      Product_supplier.create!(supplier: current, product: instance)
    end
  end

  end



end




puts 'Seed complete! 🌱'
