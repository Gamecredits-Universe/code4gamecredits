task :reassign_noreply_tips => :environment do
  logger = Rails.logger
  logger.info "Reassigning noreply tips"

  User.transaction do
    User.where("email like '%@users.noreply.github.com'").each do |user|
      next unless user.nickname.present?

      all = User.where(nickname: user.nickname)
      users_with_address = all.select(&:bitcoin_address)
      next if users_with_address.size != 1

      real_user = users_with_address.first
      logger.info "Real user: #{real_user.inspect}"

      all.each do |other|
        next if other == real_user
        logger.info "Reassigning tips from user #{other.inspect}"
        other.tips.each do |tip|
          if tip.project.disabled?
            logger.info "Skipping disabled project on tip #{tip.inspect}"
            next
          end
          logger.info "Reassigning tip #{tip.inspect}"
          tip.user = real_user
          if tip.refunded?
            logger.info "Canceling refunded state"
            tip.refunded_at = nil
          end
          if ENV["PROCEED"] == "yes"
            tip.save!
          end
        end
      end
    end
  end
end
