module BlogDecorator
  extend ActiveSupport::Concern

  def feature_image
    @feature_image ||= blog_images.find(&:is_feature).primary_content
  end

  BlogImage::SELECTED_ATTRS.push(:thumb_url).each do |attr|
    define_method("feature_image_#{attr}"){feature_image[attr]}
  end
end
