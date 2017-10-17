class SubcribersController < ApplicationController
  def create
    if params["email"].present?
      @subcriber = Subcriber.new
      @subcriber.email = params["email"]
      @subcriber.save
      flash[:success] = "Bạn đã đăng kí theo dõi thành công!"
    else
      flash[:danger] = "Đã có lỗi xảy ra"
    end
    redirect_to :root
  end
end
