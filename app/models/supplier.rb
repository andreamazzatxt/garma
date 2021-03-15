class Supplier < ApplicationRecord
  has_many :product_suppliers
  has_many :products, through: :product_suppliers
  validates :name, :address, :country, presence: true
end
