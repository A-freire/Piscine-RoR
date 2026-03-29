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
      can %i[access dashboard], :rails_admin
    elsif user.mod?
      can %i[access dashboard], :rails_admin
      can :manage, Product
      can :manage, Brand
    end
  end
end
