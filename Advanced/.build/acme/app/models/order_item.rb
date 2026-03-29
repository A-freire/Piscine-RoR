class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :quantity, numericality: { greater_than: 0 }
  validates :product_name, :brand_name, presence: true

  def line_total
    quantity * unit_price
  end
end
