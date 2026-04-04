class NotificationBroadcastJob < ApplicationJob
  queue_as :broadcasts

  def perform(message_id)
    message = Message.includes(:user, :chat_room).find_by(id: message_id)
    return unless message

    User.where.not(id: message.user_id).find_each do |user|
      NotificationsChannel.broadcast_to(
        user,
        {
          html: ApplicationController.render(
            partial: "notifications/notification",
            locals: { message: message }
          )
        }
      )
    end
  end
end
