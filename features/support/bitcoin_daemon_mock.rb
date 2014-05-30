class BitcoinDaemonMock
  def initialize
    @transactions = []
    @addresses_by_account = Hash.new
  end

  def random_address
    "random_address"
  end

  def add_transaction(options)
    transaction = {
      "account" => "",
      "address" => random_address,
      "category" => "receive",
      "amount" => 10.0,
      "confirmations" => 10,
      "blockhash" => SecureRandom.hex(64),
      "blockindex" => 3,
      "txid" => SecureRandom.hex(64),
      "time" => Time.now.to_i,
    }.merge(options.stringify_keys)
    @transactions << transaction
  end

  def list_transactions(account = "", count = 10, from = 0)
    @transactions.select { |t| account == "*" ? true : (t["account"] == account) }[from, count]
  end

  def send_many(account, recipients, minconf = 1)
    txid = SecureRandom.hex(64)
    recipients.each do |recipient, amount|
      @transactions << {
        "account" => account,
        "address" => recipient,
        "category" => "send",
        "amount" => -amount.to_f,
        "confirmations" => 10,
        "blockhash" => SecureRandom.hex(64),
        "blockindex" => 3,
        "txid" => txid,
        "time" => Time.now.to_i,
      }
    end
    txid
  end

  def get_new_address(account)
    @addresses_by_account[account] ||= []
    address = SecureRandom.hex(10)
    @addresses_by_account[account] << address
    address
  end

  def get_addresses_by_account(account)
    @addresses_by_account[account] || []
  end

  def get_balance(account)
    0
  end
end

Before do
  BitcoinDaemon.instance_eval do
    @bitcoin_daemon = BitcoinDaemonMock.new
  end
end
