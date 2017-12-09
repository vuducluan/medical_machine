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

  PRODUCT_ATTRIBUTES = [:name, :model, :price, :discount_price, :description,
    :short_description, :parameter, :brand_id, :is_parameter_table]

  PRODUCT_IMAGE_ATTRIBUTES = [:id, :title, :url, :desc, :caption, :alt, :_destroy]
  PRODUCT_CATEGORY_ATTRIBUTES = [:id, :category_id, :home_order, :list_order, :_destroy]
  PRODUCT_FIELD_ATTRIBUTES = [:id, :field_id, :menu_order, :list_order, :_destroy]

  validates :name, presence: true
  validates :model, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :short_description, presence: true
  validates :parameter, presence: true

  belongs_to :brand

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories

  has_many :product_fields, dependent: :destroy
  has_many :fields, through: :product_fields
  accepts_nested_attributes_for :product_fields

  scope :sort_from_price, -> min_price do
    where "price >= ?", min_price
  end

  scope :sort_to_price, -> max_price do
    where "price <= ?", max_price
  end

  scope :sort_in_range, -> range do
    where "price BETWEEN ? AND ?", range[0], range[1]
  end

  scope :by_categories, -> category_ids do
    joins(:product_categories)
      .where("product_categories.category_id IN (?)",
        category_ids)
  end

  SORT_FIELDS = {
    name: "name",
    date: "date",
    price: "price",
    price_desc: "price_desc"
  }

  def price_currency
    return unless price
    helper.number_to_currency(price*1000, unit: "", delimiter: ".", precision: 0)
  end

  def discount_price_currency
    return unless (discount_price && discount_price < price)
    helper.number_to_currency(discount_price*1000, unit: "", delimiter: ".", precision: 0)
  end

  def param_table
    return parameter unless is_parameter_table
    table = []
    parameter.split(",").each do |p|
      table << {title: p.split(":")[0], value: p.split(":")[1]}
    end
    table
  end

  def category_name
    category_name = []
    categories.each do |category|
      category_name << category.name
    end
    category_name.join(", ")
  end

  def field_name
    field_name = []
    fields.each do |field|
      field_name << field.name
    end
    field_name.join(", ")
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = accessible_attributes
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!(validate: false)
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.accessible_attributes
   [:name, :model, :price, :discount_price, :description, :short_description, :parameter]
  end

  private
  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
