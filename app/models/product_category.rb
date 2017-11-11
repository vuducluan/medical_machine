class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category

  accepts_nested_attributes_for :category
end
