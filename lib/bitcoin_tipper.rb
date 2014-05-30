class BitcoinTipper
  def self.work_forever
    while true do
      self.work
    end
  end

  def self.work
    Rails.logger.info "Traversing projects..."
    Project.enabled.find_each do |project|
      if project.available_amount > 0
        Rails.logger.info " Project #{project.id} #{project.full_name}"
        project.tip_commits
      end
    end

    self.create_distributions

    Rails.logger.info "Traversing sendmanies..."
    Distribution.where(txid: nil).each do |distribution|
      distribution.send_transaction
    end

    Rails.logger.info "Refunding unclaimed tips..."
    Tip.refund_unclaimed

    Rails.logger.info "Updating projects cache..."
    Project.update_cache

    Rails.logger.info "Updating users cache..."
    User.update_cache
  end

  def self.create_distributions
    Rails.logger.info "Creating distribution"
    ActiveRecord::Base.transaction do
      Project.enabled.find_each do |project|
        tips = project.tips_to_pay
        amount = tips.sum(&:amount).to_d
        if amount > CONFIG["min_payout"].to_d * COIN
          distribution = Distribution.create(project_id: project.id)
          outs = Hash.new { 0.to_d }
          tips.each do |tip|
            tip.update_attribute :distribution_id, distribution.id
            outs[tip.user.bitcoin_address] += tip.amount.to_d / COIN
          end
          distribution.update_attribute :data, outs.to_json
          Rails.logger.info "  #{distribution.inspect}"
        end
      end
    end   
  end

end
