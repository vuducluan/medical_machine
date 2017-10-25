class ProductsController < ApplicationController
  before_action :load_data_show, only: :show
  before_action :load_data_index, only: :index

  def index
  end

  def show
  end

  private
  def load_data_show
    @product = Product.find_by id: params[:id]
    @related_products = Product.where(id: @product.categories.first
      .products.pluck(:id).uniq).limit Settings.limit.related_products
  end

  def load_data_index
    params[:page] ||= 1
    if params[:category_id]
      menu_item = Category.find_by id: params[:category_id]
    elsif params[:field_id]
      menu_item = Field.find_by id: params[:field_id]
    elsif params[:brand_id]
      menu_item = Brand.find_by id: params[:brand_id]
    end
    if menu_item
      @products_from_menu = get_products(menu_item).page(params[:page])
        .per(Settings.limit.paginate.products)
      unless @products_from_menu.blank?
        @title = menu_item.name
        get_number_show_product
      end
    end
  end

  def get_number_show_product
    limit = Settings.limit.paginate.products
    @from = (params[:page].to_i - 1) * limit + 1
    if @products_from_menu.count >= limit
      @to = params[:page].to_i * limit
    else
      @to = @products_from_menu.total_count
    end
  end

  def get_products menu_item
    if params[:sort_by] == Product::SORT_FIELDS[:name]
      menu_item.products.order(name: :desc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:date]
      menu_item.products.order(created_at: :desc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:price]
      menu_item.products.order(price: :asc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:price_desc]
      menu_item.products.order(price: :desc)
    else
      menu_item.products
    end
  end
end
