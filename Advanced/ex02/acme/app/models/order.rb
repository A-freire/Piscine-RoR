class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :status, presence: true

  def self.from_cart!(cart:, user: nil)
    transaction do
      order = create!(user: user, status: "submitted", total: cart.subtotal)

      cart.cart_items.includes(product: :brand).find_each do |cart_item|
        order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          unit_price: cart_item.product.price,
          product_name: cart_item.product.name,
          brand_name: cart_item.product.brand.name
        )
      end

      order
    end
  end
end
