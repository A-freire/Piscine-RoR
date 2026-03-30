class Like < ApplicationRecord
  default_scope { where.not(user_id: nil).where.not(cuicui_id: nil) }

  belongs_to :user
  belongs_to :cuicui

  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :cuicui_id, presence: true, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :cuicui_id }

  validate :user_must_exist
  validate :cuicui_must_exist

  private

  def user_must_exist
    errors.add(:user_id, "must exist") unless User.exists?(user_id)
  end

  def cuicui_must_exist
    errors.add(:cuicui_id, "must exist") unless Cuicui.exists?(cuicui_id)
  end
end
