class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :donate, :donors], Project
    can :read, Distribution

    if user
      can [:update, :decide_tip_amounts, :commit_suggestions, :github_user_suggestions], Project, {collaborators: {user_id: user.id}}
      can [:create], Project, {collaborators: {user_id: user.id}}
      can [:create], Distribution, project: {collaborators: {user_id: user.id}}
      can [:update, :new_recipient_form], Distribution, project: {collaborators: {user_id: user.id}}, txid: nil, sent_at: nil
      can [:send_transaction], Distribution do |distribution|
        distribution.can_be_sent?
      end
    end
  end
end
