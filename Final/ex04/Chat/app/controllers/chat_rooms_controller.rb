class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: :show

  def index
    redirect_to chat_room_path(global_room)
  end

  def show
    @messages = @chat_room.messages.includes(:user).order(:created_at, :id)
    @message = @chat_room.messages.build
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  def global_room
    @global_room ||= ChatRoom.find_or_create_by!(title: "General") do |room|
      room.user = current_user
    end
  end
end
