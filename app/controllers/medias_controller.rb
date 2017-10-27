class MediasController < ApplicationController

  def index
    if params[:media_type] == "0"
      per_page_medias = Settings.limit.paginate.documents
    else
      per_page_medias = Settings.limit.paginate.videos
    end

    @medias = Medium.where("media_type = ?", params[:media_type])
      .page(params[:page]).per(per_page_medias)
  end
end
