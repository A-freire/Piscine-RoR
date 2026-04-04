class ChatRoomsBroadcastJob < ApplicationJob
  queue_as :broadcasts

  def perform
    chat_rooms = ChatRoom.includes(:user, :messages).ordered

    ActionCable.server.broadcast(
      "chat_rooms",
      {
        html: ApplicationController.render(
          partial: "chat_rooms/room_list",
          locals: { chat_rooms: chat_rooms, current_room: nil }
        ),
        room_ids: chat_rooms.map { |chat_room| chat_room.id.to_s }
      }
    )
  end
end
