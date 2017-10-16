class PagesController < ApplicationController
  def home    
    @top_categories = Category.top_categories
    @blogs = Blog.new_articles_for_home
  end
end
