class MediasController < ApplicationController

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
end
