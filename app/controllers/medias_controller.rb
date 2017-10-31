class MediasController < ApplicationController
  before_action :load_breadcrum, only: :index

  def index
    if params[:media_type] == "0"
      per_page_medias = Settings.limit.paginate.documents
    else
      per_page_medias = Settings.limit.paginate.videos
    end

    if params[:field_id]
      @medias = Medium.where("media_type = ? AND field_id = ?", params[:media_type], params[:field_id])
        .page(params[:page]).per(per_page_medias)
    else
      @medias = Medium.where("media_type = ?", params[:media_type])
        .page(params[:page]).per(per_page_medias)
    end
  end

  private
  def load_breadcrum
    if params[:media_type] == "0"
      @breads = [{title: "Tài liệu", link: ""}]
    elsif params[:media_type] == "1"
      @breads = [{title: "Video", link: ""}]
    end
  end
end
