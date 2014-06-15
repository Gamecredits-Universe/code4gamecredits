class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:github]
  devise :confirmable, reconfirmable: true

  validates :bitcoin_address, bitcoin_address: true
  validates :password, confirmation: true

  has_many :tips

  before_create :generate_login_token!, unless: :login_token?

  acts_as_commontator
  acts_as_commontable

  def github_url
    "https://github.com/#{nickname}"
  end

  def balance
    tips.unpaid.sum(:amount)
  end

  def full_name
    name.presence || nickname.presence || email
  end

  def self.update_cache
    commits_counts = Tip.group(:user_id).count
    paid_sums = Tip.paid.group(:user_id).sum(:amount)

    find_each do |user|
      user.commits_count = commits_counts[user.id] || 0
      user.withdrawn_amount = paid_sums[user.id] || 0
      user.save
    end
  end

  def has_password?
    encrypted_password_was.present?
  end

  def password_required?
    false
  end

  def email_required?
    false
  end

  def recipient_label
    if nickname.present?
      nickname
    elsif email.present?
      if new_record?
        "#{email} (new user)"
      else
        email
      end
    else
      "Unknown user"
    end
  end

  def valid_github_user?
    return false unless nickname.present?

    client = Octokit::Client.new(client_id: CONFIG['github']['key'], client_secret: CONFIG['github']['secret'])
    begin
      client.user(nickname)
      true
    rescue Octokit::NotFound
      false
    end
  end

  def reset_confirmation_token!
    generate_confirmation_token!
  end

  private

  def generate_login_token!
    loop do
      self.login_token = SecureRandom.urlsafe_base64
      break unless User.exists?(login_token: login_token)
    end
  end

end
