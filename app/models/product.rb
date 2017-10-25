class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :label

  has_many :product_images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
end
