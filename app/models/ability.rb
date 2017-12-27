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

    cannot :index, User unless @user.admin

    can :manage, Project, user_id: @user.id
    can :manage, Task, project: { user_id: @user.id }
    can :manage, Sprint, user_id: @user.id
    can :manage, Day, sprint: { user_id: @user.id }
    can :manage, DayTask, day: { sprint: { user_id: @user.id } }
    can :manage, SprintProject, sprint: { user_id: @user.id }
  end
end
