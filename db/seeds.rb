require 'json'
require 'open-uri'

puts 'Start seeding... 🤟'
User.destroy_all
Product.destroy_all
Fabric.destroy_all
Brand.destroy_all


olivia = User.new(
  email: 'olivia@gmail.com',
  password: 'password',
  first_name: 'Olivia',
  last_name: 'Smith',
  birthday: '21/11/1989',
  gender: 'female'
  )
picture = URI.open('https://cdn.nohat.cc/thumb/f/720/comrawpixel541200.jpg')
olivia.photo.attach(io: picture, filename: 'olivia.jpg', content_type: 'image/jpg')
olivia.save!

puts 'Users seed done! 💪'

# GENERATE FABRICS INSTANCES

fabrics = JSON.parse(open('db/scraped_data/fibers.json').read)
fabrics.each do |fabric|
  Fabric.create!(
      name: fabric["name"].downcase,
      description: fabric["description"],
      rating: fabric["is_sustainable"] ? 1 : 0
    )
end

puts 'Fibers seed done! 💪'
# BRANDS INSTANCES

brands = JSON.parse(open('db/scraped_data/brands.json').read)
brands.each do |brand|
  Brand.create!(
    name: brand["name"],
    rating: brand["rating"],
    planet_rating: brand["subratings"]["planet"],
    people_rating: brand["subratings"]["people"],
    animals_rating: brand["subratings"]["animals"],
    planet_description: brand["description"]["planet"],
    people_description: brand["description"]["people"],
    animals_description: brand["description"]["animals"]
    )
end

puts 'Brands seed done! 💪'

# HM PRODUCT INSTANCES
hm_products = JSON.parse(open('db/scraped_data/hm_items.json').read)

hm_products.each do |product|
  p product
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["depatment"], # Typo in the scraper leave like this
            photo_url: product["img"],
            brand: Brand.where(name: product["brand"]).take
            )

  product["composition"].each do |material|
    p material["fiber"].downcase
    p fabric = Fabric.where(name: material["fiber"].downcase).take
    UsedMaterial.create!(
                percentage: material["percentage"],
                fabric: fabric,
                product: instance
                )
  end

    if product["suppliers"]["exist?"]
      product["suppliers"]["list"].each do |supplier|
        current = Supplier.create!(
          name: supplier["name"],
          country: supplier["country"],
          address: supplier["address"]
        )
      ProductSupplier.create!(supplier: current, product: instance)
      end
    end

end




puts 'Seed complete! 🌱'
