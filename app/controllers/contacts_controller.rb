class ContactsController < ApplicationController
  def index
    @contact = Subcriber.new
  end

  def create
    @contact = Subcriber.new(contact_params)
    if @contact.save
      flash[:success] = "Bạn đã gửi phản hồi thành công!"
    else
      flash[:danger] = "Đã có lỗi xảy ra!"
    end
    redirect_to :contacts
  end

  private
  def contact_params
    params.require(:subcriber).permit(:email, :full_name, :phone, :title, :content)
  end
end
