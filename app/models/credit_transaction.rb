# Credit adds funds to the target_wallet; source_wallet is nil
class CreditTransaction < Transaction
  def apply
    raise "Target wallet must be present for a credit transaction" unless target_wallet

    self.save!
  end
end
