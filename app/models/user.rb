class User < ApplicationRecord
  has_secure_password
  has_many :collections, -> { order(position: :asc) }, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks

  has_attached_file :avatar, styles: { thumb: "60x60#" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates_presence_of :email

  def avatar_thumb
    avatar.url(:thumb)
  end

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
