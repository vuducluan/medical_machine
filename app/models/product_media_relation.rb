class ProductMediaRelation < ApplicationRecord
  belongs_to :product
  belongs_to :medium
end
