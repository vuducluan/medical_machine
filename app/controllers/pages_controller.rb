class PagesController < ApplicationController
  def home
    @top_categories = Category.top_categories
    @blogs = Blog.new_articles_for_home
    @subcriber = Subcriber.new
    @sliders = SliderCatalog.where(image_type: "slider")
    @catalogs = SliderCatalog.where(image_type: "catalog").limit 2
    get_products_anphabet
    @fields = Field.all.limit 10
  end

  private
  def get_products_anphabet
    @product_array = []
    (97..122).each do |anphabet|
      product = Category.by_anphabet(anphabet.chr)
      if product.size > 0
        slice_size = (product.size/3.0).ceil
        @product_array << product.each_slice(slice_size).to_a
      end
    end
  end
end
