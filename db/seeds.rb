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

# ATTACHING PHOTOS

patagonia = Brand.find_by(name: "Patagonia")
picture = URI.open('https://1000logos.net/wp-content/uploads/2017/11/Patagonia-Logo.png')
patagonia.photo.attach(io: picture, filename: 'brand-logo-patagonia.jpg', content_type: 'image/png')

nike = Brand.find_by(name: "Nike")
picture = URI.open('https://play-lh.googleusercontent.com/eLqKK4MkDoXXbD_F3A_2rs-othxTESxbocvyOGyhAmbNCydgnYKczItIY2-HLYJmhr6Q')
nike.photo.attach(io: picture, filename: 'brand-logo-nike.jpg', content_type: 'image/webp')

hm = Brand.find_by(name: "HM")
picture = URI.open('https://play-lh.googleusercontent.com/e7M61dxjxDtLLALsqUR3c6yDKsSNljmyK8gt6M22luXPjeA50JiPA185wLLt-P9iDTNZ')
hm.photo.attach(io: picture, filename: 'brand-logo-hm.jpg', content_type: 'image/webp')

zara = Brand.find_by(name: "Zara")
picture = URI.open('https://play-lh.googleusercontent.com/Etar8ijdCl_bYMpgCEnHlS505Dkgh-BmUJjmQCSlzyv-8o8Acp7BFxfFiGtju1DTMuqT')
zara.photo.attach(io: picture, filename: 'brand-logo-zara.jpg', content_type: 'image/webp')

puts 'Brands seed done! 💪'

# HM PRODUCT INSTANCES
hm_products = JSON.parse(open('db/scraped_data/hm_items.json').read)

hm_products.each do |product|
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["depatment"], # Typo in the scraper leave like this
            photo_url: product["img"],
            brand: Brand.where(name: product["brand"]).take
            )

  product["composition"].each do |material|
    fabric = Fabric.where(name: material["fiber"].downcase).take
    UsedMaterial.create!(
                percentage: material["percentage"],
                fabric: fabric,
                product: instance
                )
  end

    if product["suppliers"] && product["suppliers"]["exist?"]
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
