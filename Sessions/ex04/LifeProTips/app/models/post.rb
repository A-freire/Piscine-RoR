class Post < ApplicationRecord
  belongs_to :user
  belongs_to :last_editor,
             class_name: "User",
             foreign_key: :last_editor_id,
             optional: true,
             inverse_of: :edited_posts

  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }
  validates :content, presence: true

  scope :recent_first, -> { includes(:user, :last_editor).order(created_at: :desc) }

  def vote_total
    votes.sum(:value)
  end

  def author_name
    user.name
  end

  def editor_name
    last_editor&.name
  end

  def edited?
    last_editor.present? && last_edited_at.present?
  end
end
