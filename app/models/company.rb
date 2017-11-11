class Company < ApplicationRecord
  COMPANY_ATTRIBUTES = [:name, :about, :address, :phone, :contact_info, :work_time,
    :email, :facebook, :instagram, :website]

  validates :name, presence: true
  validates :about, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :contact_info, presence: true
  validates :work_time, presence: true
  validates :email, presence: true
end
