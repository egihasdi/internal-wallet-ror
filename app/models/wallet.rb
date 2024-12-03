class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
end
