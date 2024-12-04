# Transfer moves funds from the source_wallet to the target_wallet
class TransferTransaction < Transaction

  def apply
    unless source_wallet && target_wallet
      raise "Both source and target wallets must be present for a transfer transaction"
    end

    ApplicationRecord.transaction do
      raise "Insufficient balance in source wallet" unless source_wallet.balance >= amount
      self.save!
    end
  end

end
