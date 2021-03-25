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

andrea = User.new(
  email: 'andreamazza89@gmail.com',
  password: 'password',
  first_name: 'Andrea',
  last_name: 'Mazza',
  birthday: '21/11/1989',
  gender: 'male'
  )
picture = URI.open('https://res.cloudinary.com/djeuk9059/image/upload/v1616164519/IMG_0413_ngbdoh.jpg')
andrea.photo.attach(io: picture, filename: 'andrea.jpg', content_type: 'image/jpg')
andrea.save!

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
picture = URI.open('https://res.cloudinary.com/djeuk9059/image/upload/v1616159085/patagonia_etmaqp.png')
patagonia.photo.attach(io: picture, filename: 'brand-logo-patagonia.jpg', content_type: 'image/png')
p 'patagonia pic ok '
nike = Brand.find_by(name: "Nike")
picture = URI.open('https://play-lh.googleusercontent.com/eLqKK4MkDoXXbD_F3A_2rs-othxTESxbocvyOGyhAmbNCydgnYKczItIY2-HLYJmhr6Q')
nike.photo.attach(io: picture, filename: 'brand-logo-nike.jpg', content_type: 'image/webp')
p 'nike pic ok '
hm = Brand.find_by(name: "HM")
picture = URI.open('https://res.cloudinary.com/djeuk9059/image/upload/v1616159123/hm_enoekn.png')
hm.photo.attach(io: picture, filename: 'brand-logo-hm.jpg', content_type: 'image/webp')
p 'hm pic ok '
zara = Brand.find_by(name: "Zara")
picture = URI.open('https://play-lh.googleusercontent.com/Etar8ijdCl_bYMpgCEnHlS505Dkgh-BmUJjmQCSlzyv-8o8Acp7BFxfFiGtju1DTMuqT')
zara.photo.attach(io: picture, filename: 'brand-logo-zara.jpg', content_type: 'image/webp')
p 'zara pic ok '

tentree = Brand.find_by(name: "tentree")
tentree_pic = URI.open('https://trees.org/app/uploads/2015/11/tentree-v-black-transparent.png')
tentree.photo.attach(io: tentree_pic, filename: 'brand-logo-tentree.png', content_type: 'image/png')
p 'tentree pic ok '
north = Brand.find_by(name: "The North Face")
north_pic = URI.open('https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/2b/2f/3c/2b2f3c0a-49f6-3a77-c8e1-bc593f583e0c/source/512x512bb.jpg')
north.photo.attach(io: north_pic, filename: 'north.jpg', content_type: 'image/webp')
p 'north pic ok '
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
puts " HM DONE! "
zara_products = JSON.parse(open('db/scraped_data/zara_items.json').read)

zara_products.each do |product|
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["department"], # Typo in the scraper leave like this
            photo_url: product["img"],
            brand: Brand.where(name: product["brand"].capitalize).take
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
p "ZARA COMPLETE"

tentree_products = JSON.parse(open('db/scraped_data/tentree_items.json').read)

tentree_products.each do |product|
  p product
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["acrticle_number 1"],
            department: product["department"],
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
        current = Supplier.create!(
          name: "Anonymous",
          country: product["supplier"],
          address: "-"        )
      ProductSupplier.create!(supplier: current, product: instance)

end

p "TENTREE COMPLETE"

patagonia_products = JSON.parse(open('db/scraped_data/patagonia_items.json').read)

patagonia_products.each do |product|
  p product
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["depatment"],
            photo_url: product["img"],
            brand: Brand.where(name: product["brand"].downcase.capitalize).take
            )

  product["composition"].each do |material|
    fabric = Fabric.where(name: material["fiber"].downcase).take
    UsedMaterial.create!(
                percentage: material["percentage"],
                fabric: fabric,
                product: instance
                )
  end
  if product["supplier"] && product["supplier"]["exist?"]
      product["supplier"]["list"].each do |supplier|
        current = Supplier.create!(
          name: supplier["name"],
          country: supplier["country"],
          address: supplier["address"]
        )
      ProductSupplier.create!(supplier: current, product: instance)
      end
    end
end

p "PATAGONIA COMPLETE"

north_products = JSON.parse(open('db/scraped_data/north_face_items.json').read)
north_products.each do |product|
  p product
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["department"],
            photo_url: product["img"],
            brand: Brand.where(name: "The North Face").take
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

p "NIKE COMPLETE"

nike_products = JSON.parse(open('db/scraped_data/nike_items.json').read)
nike_products.each do |product|
  p product
  instance = Product.create!(
            name: product["name"],
            category: product["article_type"],
            article_number: product["article_number"],
            department: product["department"],
            photo_url: product["img"],
            brand: Brand.where(name: "Nike").take
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
