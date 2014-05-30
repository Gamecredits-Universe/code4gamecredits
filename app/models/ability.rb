class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.nickname.present?
      can [:update, :decide_tip_amounts], Project, collaborators: {login: user.nickname}
      can [:create, :read], Project
      can [:create, :recipient_suggestions, :read, :send_transaction], Distribution, project: {collaborators: {login: user.nickname}}
    end
  end
end
