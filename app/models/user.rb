class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :garderobe_items, dependent: :destroy # if we remove a user we want to remove also all his saved guardobe_items
  has_many :products, through: :garderobe_items
  validates :first_name, :last_name, :birthday, :gender, :password, presence: true
  has_one_attached :photo
  has_many :authentication_tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :token_authenticatable

  def karma
    total_rating = products.reduce(0) { |sum, product| sum + product.total_rating }
    total_rating = products.size.zero? ? 0 : (total_rating / products.size).round
    karma = 'bad'
    karma = 'medium' if total_rating == 3
    karma = 'good' if total_rating == 4 || total_rating == 5
    karma = 'neutral' if total_rating.zero?
    return karma
  end

  def products_hash
    products.map do |product|
      {
        name: product.name,
        brand: product.brand.name,
        rating: product.total_rating,
        photo: product.photo_url,
        category: product.category,
        department: product.department
      }
    end
  end
end
