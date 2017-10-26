class CategoryRelation < ApplicationRecord
  belongs_to :parent, class_name: Category.name
  belongs_to :children, class_name: Category.name
end
