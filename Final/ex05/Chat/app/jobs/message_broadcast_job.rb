class MessageBroadcastJob < ApplicationJob
  queue_as :broadcasts

  def perform(message_id)
    message = Message.includes(:user, :chat_room).find_by(id: message_id)
    return unless message

    ActionCable.server.broadcast(
      "chat_room_#{message.chat_room_id}",
      {
        html: ApplicationController.render(
          partial: "messages/message",
          locals: { message: message }
        )
      }
    )
  end
end
