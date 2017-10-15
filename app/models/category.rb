class Category < ApplicationRecord
  include CategoryDecorator
  
  scope :top_categories,-> do 
    where("level = ?", Settings.category.highest_level).order "category_order"
  end
end
