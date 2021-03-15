class Product < ApplicationRecord
  belongs_to :brand
  has_many :garderobe_items, dependent: :destroy # if we delete a product we want also to delete all the garderobe_items.
  has_many :used_materials, dependent: :destroy
  has_many :fabrics, through: :used_materials
  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers
  validates :name, :url_photo, :article_number, :category, :department, :brand, presence: true
end
