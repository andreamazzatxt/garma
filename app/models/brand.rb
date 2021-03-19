class Brand < ApplicationRecord
  has_many :products
  has_one_attached :photo
  validates :name, :rating, :planet_rating, :people_rating, :animals_rating, :planet_description, :people_description, :animals_description, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_brand_name,
   against: :name,
      using: {
        tsearch: { prefix: true }
      }
end
