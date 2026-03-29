class Book < ApplicationRecord
  scope :ordered, -> { order(:name, :id) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
