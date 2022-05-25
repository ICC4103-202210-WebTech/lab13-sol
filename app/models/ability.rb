# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.class.name == "Customer"
      can :manage, Order, customer_id: user.id
      can :manage, Customer, customer_id: user.id
      can :read, Event, :all
    elsif user.present? and user.class.name == "Admin"
      can :manage, :all
    else
      can :read, Event
    end
  end
end
