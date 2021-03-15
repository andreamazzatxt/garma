class Fabric < ApplicationRecord
  has_many :used_materials
  has_many :products, through: :used_materials
  validates :description, :name, :rating,  presence: true
end
