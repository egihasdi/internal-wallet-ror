class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", polymorphic: true, optional: true
  belongs_to :target_wallet, class_name: "Wallet", polymorphic: true, optional: true

  validates :amount, numericality: {greater_than: 0}
  validate :sufficient_balance
  validate :valid_wallets

  after_create :refresh_wallets

  private

  def sufficient_balance
    if !source_wallet.nil? && source_wallet.balance < amount
      errors.add(:amount, "Insufficient balance in source wallet")
    end
  end

  def valid_wallets
    if source_wallet.nil? && target_wallet.nil?
      errors.add(:base, "Transaction must have at least one wallet (source or target)")
    end

    if source_wallet == target_wallet
      errors.add(:base, "Source and target wallets must be different")
    end
  end

  def refresh_wallets
    source_wallet&.reload
    target_wallet&.reload
  end
end

# prevent creation from Transaction class
