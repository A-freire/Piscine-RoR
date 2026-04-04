class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :ordered, -> { order(:title, :id) }

  after_commit :broadcast_rooms_refresh, on: [:create, :destroy]

  private

  def broadcast_rooms_refresh
    ChatRoomsBroadcastJob.perform_later
  end
end
