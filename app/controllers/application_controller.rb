class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_menu_data

  def get_menu_data
    get_categories_anphabet
    @fields = Field.all.limit Settings.limit.product_field
    get_brands
  end

  private
  def get_categories_anphabet
    @category_array = []
    (97..122).each do |anphabet|
      category = Category.by_anphabet(anphabet.chr)
      slice_size = (category.size/Settings.limit.menu_block.a_to_z).ceil
      next unless category.present?
      @category_array << category.each_slice(slice_size).to_a
    end
  end

  def get_brands
    brands = Brand.all
    slice_size = (brands.size/Settings.limit.menu_block.brand).ceil
    @brand_array = brands.each_slice(slice_size).to_a
  end
end
