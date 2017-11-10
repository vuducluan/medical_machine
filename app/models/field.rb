class Field < ApplicationRecord
  has_many :product_fields, dependent: :destroy
  has_many :products, through: :product_fields

  validates :name, presence: true
end
