class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :garderobe_items, dependent: :destroy # if we remove a user we want to remove also all his saved guardobe_items
  has_many :products, through: :garderobe_items
  validates :first_name, :last_name, :birthday, :gender, :password, presence: true
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
