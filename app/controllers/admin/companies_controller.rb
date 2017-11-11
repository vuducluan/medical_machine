class Admin::CompaniesController < Admin::BaseController
  before_action :load_company, only: [:show, :edit, :update]

  def update
    if @company.update_attributes(company_params)
      flash[:success] = "Chỉnh sửa thàng công"
      redirect_to admin_company_path()
    else
      flash[:danger] = @company.errors.full_messages
      render :edit
    end
  end

  private
  def load_company
    @company = Company.first
  end

  def company_params
    params.require(:company).permit(Company::COMPANY_ATTRIBUTES)
  end
end
