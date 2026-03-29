class Product < ApplicationRecord
  belongs_to :brand
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :nullify

  mount_uploader :pict, PictUploader

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered, -> { includes(:brand).order(created_at: :desc) }
end
