class Cuicui < ApplicationRecord
  public_constant :ActiveRecord_Relation

  default_scope { where.not(content: nil) }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users, through: :likes

  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :content, presence: true, uniqueness: true
  validates :user_id, presence: true, numericality: { only_integer: true }

  validate :user_must_exist

  scope :top, lambda {
    left_joins(:likes)
      .group(:id)
      .having("COUNT(likes.id) > 0")
      .order(Arel.sql("COUNT(likes.id) DESC, cuicuis.id ASC"))
  }

  def fame
    likes.count
  end

  private

  def user_must_exist
    errors.add(:user_id, "must exist") unless User.exists?(user_id)
  end
end
