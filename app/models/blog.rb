class Blog < ApplicationRecord
  include BlogDecorator
  
  belongs_to :template
  belongs_to :blog_category
  has_many :blog_images, dependent: :destroy

  scope :new_articles_for_home, -> do 
    where(blog_category_id: Settings.blog_category.news)
      .order("created_at DESC").limit(Settings.limit.blog_home_page)
      .includes :blog_images
  end
end
