class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_menu_data

  def get_menu_data
    get_products_anphabet
    @fields = Field.all.limit Settings.limit.product_field
    get_brands
  end

  private
  def get_products_anphabet
    @product_array = []
    (97..122).each do |anphabet|
      product = Category.by_anphabet(anphabet.chr)
      slice_size = (product.size/Settings.limit.menu_block.a_to_z).ceil
      next unless product.present?
      @product_array << product.each_slice(slice_size).to_a
    end
  end

  def get_brands
    brands = Brand.all
    slice_size = (brands.size/Settings.limit.menu_block.brand).ceil
    @brand_array = brands.each_slice(slice_size).to_a
  end
end
