class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :label

  has_many :product_images

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :product_fields, dependent: :destroy
  has_many :fields, through: :product_fields

  SORT_FIELDS = {
    name: "byname",
    date: "bydate",
    price: "pricea",
    price_desc: "priced"
  }
end
