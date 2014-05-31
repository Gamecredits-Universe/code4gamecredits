class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, Distribution

    if user and user.nickname.present?
      can [:update, :decide_tip_amounts], Project, collaborators: {login: user.nickname}
      can [:create], Project
      can [:create, :recipient_suggestions, :send_transaction], Distribution, project: {collaborators: {login: user.nickname}}
    end
  end
end
