class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  validates :session_token, presence: true, uniqueness: true

  def add_product(product)
    item = cart_items.find_or_initialize_by(product: product)
    item.quantity = item.quantity.to_i + 1
    item.save!
    item
  end

  def subtotal
    cart_items.includes(:product).sum(&:line_total)
  end

  def total_items
    cart_items.sum(:quantity)
  end

  def empty!
    cart_items.destroy_all
  end
end
