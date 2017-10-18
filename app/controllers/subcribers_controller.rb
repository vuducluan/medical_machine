class SubcribersController < ApplicationController
  def create
    @subcriber = Subcriber.new(subcriber_params)
    if @subcriber.save
      flash[:success] = "Bạn đã đăng kí theo dõi thành công!"
    else
      flash[:danger] = "Đã có lỗi xảy ra"
    end
    redirect_to :root
  end

  private
  def subcriber_params
    params.require(:subcriber).permit(:email)
  end
end
