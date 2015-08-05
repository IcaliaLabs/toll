module Toll

  # The keys to use for user authentication
  mattr_accessor :authentication_keys
  @@authentication_keys = [:email]

  # Method to configure Toll
  def self.setup
    yield self
  end
end

require "toll/version"
