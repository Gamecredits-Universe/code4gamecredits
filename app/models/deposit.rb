class Deposit < ActiveRecord::Base
  belongs_to :project
  belongs_to :donation_address, inverse_of: :deposits

  def fee
    (amount * CONFIG["our_fee"]).to_i
  end

  def available_amount
    [amount - fee, 0].max
  end

end
