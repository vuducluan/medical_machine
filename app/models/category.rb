class Category < ApplicationRecord
  include CategoryDecorator

  has_many :product_categories, dependent: :destroy
  has_many :products, :through => :product_categories

  has_many :parent_relations,
    foreign_key: :children_id,
    class_name: CategoryRelation.name

  has_many :children_relations,
    foreign_key: :parent_id,
    class_name: CategoryRelation.name

  has_many :parents,
    through: :parent_relations,
    class_name: Category.name

  has_many :childrens,
    through: :children_relations,
    class_name: Category.name

  scope :top_categories,-> do
    where("level = ?", Settings.category.highest_level).order "category_order"
  end

  scope :by_anphabet, -> character do
    where("LEFT(name, 1) = ? AND level = ?", character.upcase,
      Settings.category.lowest_level)
  end

  def list_home_products
    return unless level == Settings.category.middle_level
    list_categories = [id]
    if c = childrens
      list_categories << c.pluck(:id)
    end
    Product.by_categories(list_categories.flatten).order(:home_order)
      .limit(Settings.limit.category_home_block)
  end

  def all_children_ids
    cat = [id]
    if childrens
      cat << childrens.pluck(:id)
      childrens.each do |c|
        if c.childrens
          cat << c.childrens.pluck(:id)
        end
      end
    end
    cat.flatten
  end
end
