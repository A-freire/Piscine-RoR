class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:show, :destroy]
  before_action :load_chat_rooms, only: [:index, :show]

  def index
    @new_chat_room = current_user.chat_rooms.build
  end

  def show
    @messages = @chat_room.messages.includes(:user).order(:created_at, :id)
    @message = @chat_room.messages.build
    @new_chat_room = current_user.chat_rooms.build
  end

  def create
    @new_chat_room = current_user.chat_rooms.build(chat_room_params)

    if @new_chat_room.save
      redirect_to @new_chat_room, notice: "Chat room created."
    else
      @chat_rooms = ChatRoom.includes(:user).ordered
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    unless @chat_room.user == current_user
      redirect_to chat_rooms_path, alert: "Only the creator can delete this room."
      return
    end

    @chat_room.destroy
    redirect_to chat_rooms_path, notice: "Chat room deleted."
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find_by(id: params[:id])
    return if @chat_room

    redirect_to chat_rooms_path, alert: "This chat room no longer exists."
  end

  def load_chat_rooms
    @chat_rooms = ChatRoom.includes(:user).ordered
  end

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
