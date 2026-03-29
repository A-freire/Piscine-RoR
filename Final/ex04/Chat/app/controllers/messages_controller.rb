class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        @form_message = @chat_room.messages.build
        format.html { redirect_to chat_room_path(@chat_room) }
        format.js
      else
        @form_message = @message
        format.html do
          @chat_rooms = ChatRoom.includes(:user).ordered
          @messages = @chat_room.messages.includes(:user).order(:created_at, :id)
          @new_chat_room = current_user.chat_rooms.build
          render "chat_rooms/show", status: :unprocessable_entity
        end
        format.js { render :create, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
