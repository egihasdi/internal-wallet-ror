class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", polymorphic: true, optional: true
  belongs_to :target_wallet, class_name: "Wallet", polymorphic: true, optional: true

  validates :amount, numericality: {greater_than: 0}
end
