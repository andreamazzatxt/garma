class Brand < ApplicationRecord
  has_many :products
  has_one_attached :photo
  validates :name, :rating, :planet_rating, :people_rating, :animals_rating, :planet_description, :people_description, :animals_description, presence: true
end
