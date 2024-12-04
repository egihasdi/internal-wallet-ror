class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", polymorphic: true, optional: true
  belongs_to :target_wallet, class_name: "Wallet", polymorphic: true, optional: true
end

class CreditTransaction < Transaction
  def apply
    wallet.update(balance: wallet.balance + amount)
  end
end

class DebitTransaction < Transaction
  def apply
    wallet.update(balance: wallet.balance - amount)
  end
end

class TransferTransaction < Transaction
  def apply
    source_wallet.update(balance: source_wallet.balance - amount)
    target_wallet.update(balance: target_wallet.balance + amount)
  end
end
