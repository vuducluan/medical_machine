class Category < ApplicationRecord
  include CategoryDecorator

  scope :top_categories,-> do
    where("level = ?", Settings.category.highest_level).order "category_order"
  end

  scope :by_anphabet, -> character do
    where("LEFT(name, 1) = ? AND level = ?", character.upcase,
      Settings.category.lowest_level)
  end
end
