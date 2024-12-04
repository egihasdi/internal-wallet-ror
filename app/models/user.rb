class User < ApplicationRecord
  has_secure_password
  has_one :wallet, as: :walletable, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def generate_jwt
    JWT.encode({user_id: self.id, exp: 24.hours.from_now.to_i}, Rails.application.secret_key_base)
  end
end
