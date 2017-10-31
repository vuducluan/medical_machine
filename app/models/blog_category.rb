class BlogCategory < ApplicationRecord
  has_many :blog_category_relations, dependent: :destroy
  has_many :blogs, through: :blog_category_relations
end
