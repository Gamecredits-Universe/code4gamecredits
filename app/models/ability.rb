class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.nickname.present?
      can [:update, :decide_tip_amounts], Project, collaborators: {login: user.nickname}
      can :create, Project
    end
  end
end
