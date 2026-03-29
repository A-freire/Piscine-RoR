class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  def display_name
    username.presence || email.to_s.split("@").first
  end
end
