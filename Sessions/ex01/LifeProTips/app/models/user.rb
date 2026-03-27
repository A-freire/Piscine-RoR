class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :edited_posts,
           class_name: "Post",
           foreign_key: :last_editor_id,
           inverse_of: :last_editor,
           dependent: :nullify

  before_validation :normalize_identity_fields

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true

  def points
    posts.joins(:votes).sum("votes.value")
  end

  def can_upvote_posts?
    admin? || points >= 2
  end

  def can_downvote_posts?
    admin? || points >= 4
  end

  def can_edit_other_posts?
    admin? || points >= 10
  end

  def privilege_labels
    labels = []
    labels << "Administrator" if admin?
    labels << "Can up-vote posts from other users" if can_upvote_posts?
    labels << "Can down-vote posts from other users" if can_downvote_posts?
    labels << "Can edit posts from other users" if can_edit_other_posts?
    labels << "No specific rights" if labels.empty?
    labels
  end

  private

  def normalize_identity_fields
    self.name = name.to_s.strip
    self.email = email.to_s.strip.downcase
  end
end
