class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  
  def new_tip user, tip
    @user = user
    @tip  = tip

    mail to: user.email, subject: "You received a tip for your commit"
  end

  def security_issue(user)
    @user = user
    mail to: user.email, subject: "Security issue on code4gamecredits.com"
  end

  def address_request(tip, collaborator)
    @collaborator = collaborator
    @tip = tip
    @user = tip.user
    mail to: @user.email, subject: "[#{tip.project.name}] Provide an address to get your reward"
  end
end
