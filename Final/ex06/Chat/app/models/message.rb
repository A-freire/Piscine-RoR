class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :content, presence: true

  after_create_commit :enqueue_realtime_jobs

  private

  def enqueue_realtime_jobs
    MessageBroadcastJob.perform_later(id)
    NotificationBroadcastJob.perform_later(id)
    ChatRoomsBroadcastJob.perform_later
  end
end
