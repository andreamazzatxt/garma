class UsedMaterial < ApplicationRecord
  belongs_to :fabric
  belongs_to :product
  validates :percentage, presence: true
end
