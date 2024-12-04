class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :outgoing_transaction, as: :source_wallet, class_name: "Transaction"
  has_many :incoming_transaction, as: :target_wallet, class_name: "Transaction"

  def balance
    deposits = incoming_transaction.where(target_wallet: self).sum(:amount)
    withdrawals = outgoing_transaction.where(source_wallet: self).sum(:amount)

    deposits - withdrawals
  end
end
