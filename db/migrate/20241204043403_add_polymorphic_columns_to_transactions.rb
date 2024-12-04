class AddPolymorphicColumnsToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column(:transactions, :source_wallet_type, :string)
    add_column(:transactions, :target_wallet_type, :string)
  end
end
