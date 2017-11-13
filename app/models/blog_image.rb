class BlogImage < ApplicationRecord
  belongs_to :blog
  
  mount_uploader :url, ImageUploader

  SELECTED_ATTRS = %i(title description caption alt)

  def primary_content
    as_json(only: SELECTED_ATTRS, methods: [:thumb_url])
      .symbolize_keys
  end

  def thumb_url
    url_url :blog_thumb
  end
end
