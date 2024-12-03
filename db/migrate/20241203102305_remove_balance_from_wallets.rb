class RemoveBalanceFromWallets < ActiveRecord::Migration[8.0]
  def change
    remove_column(:wallets, :balance, :decimal)
  end
end
