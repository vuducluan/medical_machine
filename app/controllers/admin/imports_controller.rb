class Admin::ImportsController < Admin::BaseController
  def new
    @excel_product = ExcelProduct.new
  end

  def create
    if params[:excel_product]
      @excel_product = ExcelProduct.new excel_product_params
      Product.import(@excel_product.file)
      flash[:success] = "Upload sản phẩm thành công!"
      redirect_to new_admin_import_path
    else
      flash[:danger] = "Upload sản phẩm không thành công!"
      @excel_product = ExcelProduct.new
      render :new
    end
  end

  def index
    @products = Product.order(:id).limit(1)
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: 'index',filename: "new_products.xlsx"}
    end
  end

  private
  def excel_product_params
    params.require(:excel_product).permit(:file)
  end
end
