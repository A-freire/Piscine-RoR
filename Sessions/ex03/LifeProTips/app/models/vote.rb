class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :value, inclusion: { in: [-1, 1] }
  validates :user_id, uniqueness: { scope: :post_id }, unless: :admin_upvote?

  validate :author_cannot_vote_for_own_post
  validate :user_can_cast_selected_vote

  scope :recent_first, -> { includes(:user, :post).order(created_at: :desc) }

  def self.cast_by!(user:, post:, value:)
    if user.admin? && value == 1
      create!(user:, post:, value:)
    else
      vote = find_or_initialize_by(user:, post:)
      vote.value = value
      vote.save!
      vote
    end
  end

  def voter_name
    user.name
  end

  private

  def admin_upvote?
    user&.admin? && value == 1
  end

  def author_cannot_vote_for_own_post
    return unless user && post && post.user == user

    errors.add(:base, "You cannot vote for your own post.")
  end

  def user_can_cast_selected_vote
    return unless user && post
    return if user.admin?

    if value == 1 && !user.can_upvote_posts?
      errors.add(:base, "You need at least 2 points to up-vote other users' posts.")
    elsif value == -1 && !user.can_downvote_posts?
      errors.add(:base, "You need at least 4 points to down-vote other users' posts.")
    end
  end
end
