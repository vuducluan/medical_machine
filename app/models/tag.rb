class Tag < ApplicationRecord
  has_many :blog_tag_relations, dependent: :destroy
  has_many :blogs, through: :blog_tag_relations

  TAG_ATTRIBUTES = [:name, :tag_url]
end
