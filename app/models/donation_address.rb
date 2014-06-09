class DonationAddress < ActiveRecord::Base
  belongs_to :project, inverse_of: :donation_addresses
  has_many :deposits, inverse_of: :donation_address

  validates :sender_address, bitcoin_address: true, presence: true
  validates :donation_address, bitcoin_address: true

  before_create :generate_donation_address

  def generate_donation_address
    return if donation_address.present?
    raise "The project has no address label" if project.address_label.blank?
    self.donation_address = BitcoinDaemon.instance.get_new_address(project.address_label)
  end
end
