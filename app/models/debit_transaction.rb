# Debit withdraws funds from the source_wallet; target_wallet is nil
class DebitTransaction < Transaction
  def apply
    raise "Source wallet must be present for a debit transaction" unless source_wallet

    ApplicationRecord.Transaction do
      raise "Insufficient balance in source wallet" unless source_wallet.balance >= amount
      self.save!
    end
  end
end
