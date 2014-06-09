class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :donate, :donors], Project
    can :read, Distribution

    if user and user.nickname.present?
      can [:update, :decide_tip_amounts, :commit_suggestions, :github_user_suggestions], Project, collaborators: {login: user.nickname}
      can [:create], Project
      can [:create], Distribution, project: {collaborators: {login: user.nickname}}
      can [:update, :new_recipient_form], Distribution, project: {collaborators: {login: user.nickname}}, txid: nil, sent_at: nil
      can [:send_transaction], Distribution do |distribution|
        distribution.can_be_sent?
      end
    end
  end
end
