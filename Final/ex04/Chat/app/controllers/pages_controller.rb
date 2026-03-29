class PagesController < ApplicationController
  def home
    redirect_to chat_rooms_path if user_signed_in?
  end
end
