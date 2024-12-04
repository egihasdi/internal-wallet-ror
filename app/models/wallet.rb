class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :transactions, as: :source_wallet, class_name: "Transaction"
  has_many :transactions, as: :target_wallet, class_name: "Transaction"

  def balance
    deposits = transactions.where(target_wallet: self).sum(:amount)
    withdrawals = transactions.where(source_wallet: self).sum(:amount)
    deposits - withdrawals
  end
end
