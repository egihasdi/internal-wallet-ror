# Debit withdraws funds from the source_wallet; target_wallet is nil
class DebitTransaction < Transaction
  def apply
    raise "Source wallet must be present for a debit transaction" unless source_wallet

    self.save!
  end
end
