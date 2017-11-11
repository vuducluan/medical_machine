class Admin::CatalogsController < Admin::BaseController
  before_action :load_catalogs, only: :index
  before_action :load_catalog, only: [:edit, :update, :destroy]

  def index
  end

  def edit
  end

  def update
    if @catalog.update_attributes(catalog_params)
      flash[:success] = "Chỉnh sửa thàng công"
      redirect_to admin_catalogs_path(is_edit: true)
    else

    end

  end

  def new
    @catalog = SliderCatalog.new
  end

  def create
    @catalog = SliderCatalog.create(catalog_params.merge(image_type: "catalog"))
    if @catalog.valid?
      flash[:success] = "Thêm mới thàng công"
      redirect_to admin_catalogs_path(is_new: true)
    else
      flash[:danger] = @catalog.errors.full_messages
      render :new
    end

  end

  def destroy
    if @catalog
      catalog_title = @catalog.title
      if @catalog.destroy
        flash[:success] = "Xóa catalog #{catalog_title} thành công!"
      else
        flash[:danger] = @catalog.errors.full_messages
      end
    end
    redirect_to admin_catalogs_path
  end

  private
  def load_catalog
    @catalog = SliderCatalog.find_by id: params[:id]
  end

  def load_catalogs
    @catalogs = SliderCatalog.where(image_type: "catalog")
    if params[:is_new]
      @catalogs = @catalogs.order(created_at: :desc)
    elsif params[:is_edit]
      @catalogs = @catalogs.order(updated_at: :desc)
    end
  end

  def catalog_params
    params.require(:slider_catalog).permit(SliderCatalog::SLIDER_CATALOG_ATTRIBUTES)
  end
end
