class ProductField < ApplicationRecord
  belongs_to :product
  belongs_to :field
end
