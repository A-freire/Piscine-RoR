class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Product
    can :read, Brand
    can %i[show destroy], Cart
    can %i[create increment decrement destroy], CartItem
    can %i[show create], Order

    return unless user.persisted?

    if user.admin?
      can :manage, :all
      can :access, :rails_admin
      can :read, :dashboard
    elsif user.mod?
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, Product
      can :manage, Brand
    end
  end
end
