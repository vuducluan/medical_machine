class Medium < ApplicationRecord
  MEDIA_ATTRIBUTE = [:title, :description, :field_id, :url, :media_type]

  belongs_to :field

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :media_type, presence: true
  validates :field_id, presence: true
end
