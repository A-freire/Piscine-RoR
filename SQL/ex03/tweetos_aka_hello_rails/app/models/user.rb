class User < ApplicationRecord
  BANISHED_NAMES = ["42", "lancelot du lac", "Ruby"].freeze
  EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/.freeze

  default_scope { where.not(name: nil) }

  has_many :cuicuis, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_FORMAT }
  validates :since, presence: true
  validates :country, presence: true

  validate :name_is_not_banished

  def fame
    cuicuis.joins(:likes).count
  end

  def senior?
    years_active > 10
  end

  def junior?
    years_active < 10
  end

  def responses
    Comment.joins(:cuicui)
           .where(cuicuis: { user_id: id })
           .order(created_at: :desc)
           .limit(5)
  end

  def top_cuicui
    cuicuis.left_joins(:likes)
           .group(:id)
           .order(Arel.sql("COUNT(likes.id) DESC, cuicuis.id ASC"))
  end

  private

  def name_is_not_banished
    return unless BANISHED_NAMES.include?(name)

    errors.add(:name, "#{name} is banished")
  end

  def years_active
    Date.current.year - since.to_i
  end
end
