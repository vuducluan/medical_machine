module CategoryDecorator
  extend ActiveSupport::Concern

  def feature_image
    return unless level == Settings.category.highest_level
    "category/#{images_of_top_category[category_order - 1]}"
  end

  def feature_image_2
    return unless level == Settings.category.highest_level
    "category/#{images_of_top_category[category_order + 5]}"
  end

  private
  def images_of_top_category
    @images_of_top_category ||= Dir.glob("app/assets/images/category/*")
      .map do |img|
      img.split("/").last
    end.sort
  end
end
