class ProductsController < ApplicationController
  before_action :load_data_show, only: :show

  def index
  end

  def show
  end

  def load_data_show
    @product = Product.find_by id: params[:id]
    @related_products = Product.where(id: @product.categories.first
      .products.pluck(:id).uniq).limit Settings.limit.related_products
  end
end
