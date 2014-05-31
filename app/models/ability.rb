class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, Distribution

    if user and user.nickname.present?
      can [:update, :decide_tip_amounts], Project, collaborators: {login: user.nickname}
      can [:create], Project
      can [:create], Distribution, project: {collaborators: {login: user.nickname}}
      can [:update, :recipient_suggestions], Distribution, project: {collaborators: {login: user.nickname}}, txid: nil, sent_at: nil
      can [:send_transaction], Distribution do |distribution|
        distribution.can_be_sent?
      end
    end
  end
end
