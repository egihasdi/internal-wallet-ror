class AddTypeToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :type, :string
  end
end
