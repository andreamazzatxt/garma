class Product < ApplicationRecord
  belongs_to :brand
  has_many :used_materials
  has_many :fabrics, through: :used_materials
  has_many :product_suppliers
  has_many :suppliers, through: :product_suppliers
  validates :name, :url_photo, :article_number, :category, :department, :brand, presence: true
end
