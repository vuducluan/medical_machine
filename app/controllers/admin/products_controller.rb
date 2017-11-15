class Admin::ProductsController < Admin::BaseController
  before_action :load_products, only: :index
  before_action :load_product, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @product = Product.new
    @product.product_categories.build
    @product.product_images.build
  end

  def create
    format_params
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Tạo mới sản phẩm #{@product.name} thành công!"
      redirect_to admin_products_path
    else
      flash[:danger] = @product.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def product_params
    params.require(:product).permit(Product::PRODUCT_ATTRIBUTES,
      product_images_attributes: Product::PRODUCT_IMAGE_ATTRIBUTES,
      product_categories_attributes: Product::PRODUCT_CATEGORY_ATTRIBUTES)
  end

  def load_products
    get_categories
    @products = get_products_by_categories
  end

  def load_product
    @product = Product.find_by id: params[:id]
    @g_categories = Category.where(level: Settings.category.highest_level)
  end

  def format_params
    categories = params[:product][:product_categories_attributes]
    list = []
    categories.each do |key, value|
      list << value[:category_id].to_i
      unless value.keys.include?("list_order")
        params[:product][:product_categories_attributes].delete key
      end
    end
    params[:product][:product_categories_attributes].each do |key, value|
      childs = Category.find_by(id: value[:category_id]).childrens.pluck(:id)
      list.each do |l|
        if childs.include?(l)
          params[:product][:product_categories_attributes][key][:category_id] = l.to_s
        end
      end
    end
  end

  def get_categories
    @g_categories = Category.where(level: Settings.category.highest_level)
    if params[:gc_id].present?
      g_category = Category.find_by id: params[:gc_id]
      @p_categories = g_category.childrens
    else
      params[:pc_id] = params[:c_id] = nil
    end

    if params[:pc_id].present? && @p_categories.pluck(:id).include?(params[:pc_id].to_i)
      p_category = Category.find_by id: params[:pc_id]
      @categories = p_category.childrens
    else
      params[:pc_id] = params[:c_id] = nil
    end
  end

  def get_products_by_categories
    gid = params[:gc_id]
    pid = params[:pc_id]
    cid = params[:c_id]
    category_arr = []
    if gid.present? && pid.present? && cid.present?
      category_arr << gid.to_i
      category_arr << pid.to_i
      category_arr << cid.to_i
    elsif gid.present? && pid.present?
      category_arr << gid.to_i
      category_arr << pid.to_i
      category_arr << Category.find_by(id: pid).childrens.pluck(:id)
    elsif gid.present?
      category_arr << gid.to_i
      p_cates = Category.find_by(id: gid).childrens
      category_arr << p_cates.pluck(:id)
      p_cates.each do |p_id|
        category_arr << Category.find_by(id: p_id).childrens.pluck(:id)
      end
    end
    category_arr = category_arr.flatten
    return Product.all unless category_arr.size > 0
    Product.by_categories category_arr
  end
end
