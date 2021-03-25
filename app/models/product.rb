class Product < ApplicationRecord
  belongs_to :brand
  has_many :garderobe_items, dependent: :destroy # if we delete a product we want also to delete all the garderobe_items.
  has_many :used_materials, dependent: :destroy
  has_many :fabrics, through: :used_materials
  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers
  validates :name, :photo_url, :article_number, :category, :department, :brand, presence: true
  def suppliers_rating
    return 1 if suppliers.size.zero?
    return 3 if suppliers.size.positive?
  end

  def fabrics_rating
    rating = 0
    used_materials.each do |material|
      rating += material.percentage if material.fabric.rating.positive?
    end
    return rating.zero? ? 1 : (rating / 20).round
  end

  def total_rating
    return ((brand.rating + fabrics_rating + suppliers_rating) / 3).round
  end

  def garderobe_id(user)
    item = GarderobeItem.find_by(user: user, product: self)
    item.nil? ? 'false' : item.id
  end

  def self.best_items
    items = []
    Product.all.each do |product|
      if product.total_rating >= 1
        items << product.article_number
      end
    end
    return items
  end
end
