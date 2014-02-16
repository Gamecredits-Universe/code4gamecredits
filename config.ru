# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

if host = CONFIG["canonical_host"]
  use Rack::CanonicalHost, host
end

run Rails.application
