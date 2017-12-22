class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email

  def self.encode_token(payload, exp = 24.hours.from_now)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode_token(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end
end
