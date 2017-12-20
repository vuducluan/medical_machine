class Admin::TagsController < Admin::BaseController
  before_action :load_tags, only: :index

  def index
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tạo mới tag #{@tag.name} thành công!"
    else
      flash[:danger] = "Lỗi! Tạo mới tag không thành công."
    end
    redirect_to admin_tags_path()
  end

  def update
    @tag = Tag.find_by id: params[:id]
    if @tag
      @tag.update_attributes tag_params
    end

    if request.xhr?
      render json: {
        name: @tag.name,
        tag_url: @tag.tag_url
      }
    end
  end

  def destroy
    tag = Tag.find_by id: params[:id]
    if tag
      tag_name = tag.name
      if tag.destroy
        flash[:success] = "Xóa hãng #{tag_name} thành công!"
      else
        flash[:danger] = "Lỗi! Xóa hãng không thành công."
      end
    end
    redirect_to admin_tags_path()
  end
  private
  def load_tags
    @tags = Tag.all.order(name: :asc)
  end

  def tag_params
    params.require(:tag).permit(Tag::TAG_ATTRIBUTES)
  end
end
