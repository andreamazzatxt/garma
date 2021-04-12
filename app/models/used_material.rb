class UsedMaterial < ApplicationRecord
  belongs_to :fabric
  belongs_to :product
  validates :percentage, presence: true

  def composition_hash
    {
      name: fabric.name,
      percentage: percentage,
      description: fabric.description
    }
  end
end
