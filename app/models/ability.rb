class Ability
  include CanCan::Ability

  # NOTE: cancan is stupid about index actions
  # You will need to explicitly prevent :index views
  def initialize(user)
      @user = (user ||= User.new)
      #can :manage, :all
      # Users
      can :create, User
      can :read, User 
      can :update, User do |user1|
        user1.id == @user.try(:id) || @user.admin
      end

      can :index, User

      # Projects and Tasks
      can :manage, Project
      can :manage, Task
  end
end
