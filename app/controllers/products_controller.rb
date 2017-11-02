class ProductsController < ApplicationController
  before_action :load_data_show, only: :show
  before_action :load_data_index, only: :index
  before_action :load_left_menu_data, only: [:show, :index]

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
    get_new_product
    load_breadcrum
  end

  def load_breadcrum
    if params[:category_id]
      category = Category.find_by id: params[:category_id]
      @breads = [{title: category.name, link: ""}]
      if parent = category.parents.first
        @breads << {title: parent.name, link: products_path(category_id: parent.id)}
        if grand_parent = parent.parents.first
          @breads << {title: grand_parent.name, link: products_path(category_id: grand_parent.id)}
        end
      end
      @breads = @breads.reverse
    elsif params[:id]
      @breads = [{title: @product.name, link: ""}]
      if category = @product.categories.first
        @breads << {title: category.name, link: products_path(category_id: category.id)}
        if parent = category.parents.first
          @breads << {title: parent.name, link: products_path(category_id: parent.id)}
          if grand_parent = parent.parents.first
            @breads << {title: grand_parent.name, link: products_path(category_id: grand_parent.id)}
          end
        end
      end
      @breads = @breads.reverse
    elsif params[:brand_id]
      brand = Brand.find_by id: params[:brand_id]
      @breads = [{title: "Hãng sản xuất", link: products_path()}]
      @breads << {title: brand.name, link: ""}
    elsif params[:field_id]
      field = Field.find_by id: params[:field_id]
      @breads = [{title: "Lĩnh vực", link: products_path()}]
      @breads << {title: field.name, link: ""}
    else
      @breads = [{title: "Tất cả sản phẩm", link: ""}]
    end
  end

  def load_data_show
    @product = Product.find_by id: params[:id]
    @documents = Medium.where(product_id: @product.id,
      media_type: Settings.media_type.document)
    @videos = Medium.where(product_id: @product.id,
      media_type: Settings.media_type.video)
    @related_products = []
    if category = @product.categories.first
      @related_products = Product.where(id: category.products.pluck(:id).uniq)
        .limit Settings.limit.related_products
    end
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
    @products_from_menu = get_products(menu_item).page(params[:page])
      .per(Settings.limit.paginate.products)

    unless @products_from_menu.blank?
      @title = menu_item ? menu_item.name : "Tất cả sản phẩm"
      get_number_show_product
    end

    if (q = params[:query]).present?
      found_products = Product.search(body: {query: {match: {_all: q}}})
      @products_from_menu = get_products(Product.by_ids(found_products.map(&:id)))
        .page(params[:page]).per(Settings.limit.paginate.products)
      get_number_show_product if @products_from_menu.present?
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
    products = menu_item.respond_to?(:size) ? menu_item :
      (menu_item.present? ? get_products_for_menu_item(menu_item) : Product.all)
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

  def get_products_for_menu_item menu_item
    return menu_item.products unless menu_item.class.name == Category.name
    category = menu_item
    list_categories = [category.id]
    if c = category.childrens
      list_categories << c.pluck(:id)
      c.each do |children|
        if sub_c = children.childrens
          list_categories << sub_c.pluck(:id)
        end
      end
    end
    list_categories = list_categories.flatten
    Product.by_categories list_categories
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
