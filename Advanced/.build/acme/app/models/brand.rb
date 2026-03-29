class Brand < ApplicationRecord
  has_many :products, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, uniqueness: true
end
