class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :ordered, -> { order(:title, :id) }
end
