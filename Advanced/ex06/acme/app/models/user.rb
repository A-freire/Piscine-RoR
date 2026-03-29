class User < ApplicationRecord
  rolify

  has_many :orders, dependent: :nullify

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    has_role?(:admin)
  end

  def mod?
    has_role?(:mod)
  end

  def backoffice_access?
    admin? || mod?
  end
end
