class ProductsController < ApplicationController
  before_action :load_data_show, only: :show
  before_action :load_data_index, only: :index
  before_action :load_left_menu_data, only: :index

  ORDER_ATTRS = %i(username phone email received_address pay_address)

  def index
  end

  def show
  end

  def order
    @product = Product.find params[:id]
    respond_to do |format|
      format.js{render layout: false}
    end
  end

  def send_order
    respond_to do |format|
      @product = Product.find params[:id]
      @data_valid = ORDER_ATTRS.all?{|type| params[type].present?}
      user_info = params.as_json(only: ORDER_ATTRS).symbolize_keys
      return unless @data_valid
      ProductOrderMailer.order(user_info, @product).deliver_later
      format.js do 
        render layout: false
      end
    end
  end

  private
  def load_left_menu_data
    mang_ong = []
    ongs = Category.where(level: Settings.category.highest_level)
    ongs.each do |ong|
      bos = ong.childrens
      mang_bo = []
      bos.each do |bo|
        mang_con = bo.childrens
        mang_bo << [bo, mang_con]
      end
      mang_ong << [ong, mang_bo]
    end
    @categories = mang_ong
  end

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

    if (q = params[:query]).present?
      found_products = Product.search(body: {query: {match: {_all: q}}})
      @products_from_menu = get_products(Product.by_ids(found_products.map(&:id)))
        .page(params[:page]).per(Settings.limit.paginate.products)
      get_number_show_product if @products_from_menu.present?
    end
    get_new_product
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
    products = menu_item.respond_to?(:size) ? menu_item : menu_item.products
    if params[:sort_by] == Product::SORT_FIELDS[:name]
      sort_by_price products.order(name: :asc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:date]
      sort_by_price products.order(created_at: :desc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:price]
      sort_by_price products.order(price: :asc)
    elsif params[:sort_by] == Product::SORT_FIELDS[:price_desc]
      sort_by_price products.order(price: :desc)
    else
      sort_by_price products
    end
  end

  def sort_by_price products
    if params[:min_price] && params[:max_price]
      products.sort_in_range [params[:min_price].to_i, params[:max_price].to_i]
    elsif params[:min_price]
      products.sort_from_price params[:min_price].to_i
    elsif params[:max_price]
      products.sort_to_price params[:max_price].to_i
    else
      products
    end
  end

  def get_new_product
    label_id = Label.where(short_title: "hot").first.id
    @new_products = Product.where(label_id: label_id)
      .limit(Settings.limit.new_products)
  end
end
