class SliderCatalog < ApplicationRecord
  mount_uploader :url, ImageUploader

  SLIDER_CATALOG_ATTRIBUTES = [:home_order, :url, :title, :desc, :caption, :alt,
    :link]

  validates :url, presence: true
  validates :title, presence: true
end
