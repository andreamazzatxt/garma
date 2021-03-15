class UsedMaterial < ApplicationRecord
  belongs_to :fabric
  belongs_to :product
end
