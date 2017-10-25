class Product < ApplicationRecord
  searchkick mappings: {
    product: {
      _all: {enabled: true},
      properties: {
        title: {type: "string", analyzer: "default", include_in_all: true, boost: 2},
        category: {type: "string", analyzer: "default", include_in_all: true},
        brand: {type: "string", analyzer: "default", include_in_all: true},
        field: {type: "string", analyzer: "default", include_in_all: true},
      }
    }
  }, settings: {
    number_of_shards: 1,
    number_of_replicas: 1
  }

  scope :search_import,->{includes([:categories, :brand, :fields])}
  scope :by_ids,->(ids){where id: ids}

  def search_data
    {
      title: name,
      category: categories.pluck(:name).join(" "),
      brand: brand.try(:name).to_s,
      field: fields.pluck(:name).join(" ")
    }
  end

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
