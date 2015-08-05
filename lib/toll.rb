module Toll

  # The keys to use for user authentication
  mattr_accessor :authentication_keys
  @@authentication_keys = [:email]

  # Name of the authentication token attribute for the User
  mattr_accessor :authentication_token_attribute_name
  @@authentication_token_attribute_name = :authentication_token

  # Authentication Token Length
  mattr_accessor :authentication_token_length
  @@authentication_token_length = 64

  # Method to configure Toll
  def self.setup
    yield self
  end

  # Method to generate a Token
  #
  def self.token(length = Toll.authentication_token_length)
    SecureRandom.urlsafe_base64(length)
  end
end

require "toll/version"
require "toll/authenticable"
require "toll/hooks"
