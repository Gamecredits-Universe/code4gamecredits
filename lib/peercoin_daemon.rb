class PeercoinDaemon
  def self.instance
    @peercoin_daemon ||= PeercoinDaemon.new(CONFIG['peercoin'])
  end

  class RPCError < StandardError
    attr_accessor :code
    def initialize(code, message)
      @code = code
      super(message)
    end
  end

  attr_reader :config

  def initialize(config)
    @config = config || {}
  end

  def rpc(command, *params)
    %w( username password port host ).each do |field|
      raise "No #{field} provided in peercoin config" if config[field].blank?
    end

    uri = URI::HTTP.build(host: config['host'], port: config['port'].to_i)

    auth = config.slice('username', 'password').symbolize_keys

    data = {
      method: command,
      params: params,
      id: 1,
    }

    response = HTTParty.post(uri.to_s, body: data.to_json, basic_auth: auth)

    result = JSON.parse(response.body)
    if error = result["error"]
      raise RPCError.new(error["code"], error["message"])
    end
    result["result"]
  end

  def get_new_address(account = "")
    rpc('getnewaddress', account)
  end

  def list_transactions(account = "", count = 10, from = 0)
    rpc('listtransactions', account, count, from)
  end
end
