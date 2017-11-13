class Admin::MediasController < Admin::BaseController

  def index
    if params[:filter_video_field].present?
      @medias = Medium.where("media_type = ? AND field_id = ?", params[:media_type], params[:filter_video_field])
    else
      @medias = Medium.where("media_type = ?", params[:media_type])
    end
    @video = Medium.new(media_type: "1")
  end

  def create
    @video = Medium.new(media_params)
    if @video.save
      flash[:success] = "Tạo mới video #{@video.title} thành công"
      redirect_to admin_medias_path(media_type: "1")
    else
      flash[:danger] = "Lỗi! Tạo mới video không thành công"
    end
  end

  def update
    if params[:title] || params[:url] || params[:description] || params[:field_id]
      @video = Medium.find_by id: params[:id]
      if @video
        if @video.update_attributes(title: params[:title], field_id: params[:field_id],
          url: params[:url], description: params[:description])
          render json: {
            status: "update-success",
            title: @video.title,
            description: @video.description,
            url: @video.url
          }
        else
          render json: {status: "update-fail"}
        end
      end
    end
  end

  def destroy
    @video = Medium.find_by id: params[:id]
    if @video
      if @video.destroy
        flash[:success] = "Xoá video #{@video.title} thành công!"
      else
        flash[:danger] = "Lỗi! Xóa video không thành công."
      end
      redirect_to admin_medias_path(media_type: "1")
    end
  end

  private
  def media_params
    params.require(:medium).permit Medium::MEDIA_ATTRIBUTE
  end
end
