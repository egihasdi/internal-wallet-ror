class CreateStocks < ActiveRecord::Migration[8.0]
  def change
    create_table(:stocks) do |t|
      t.string(:symbol, null: false, index: {unique: true})
      t.string(:company_name, null: false)
      t.decimal(:current_price)
      t.string(:market)

      t.timestamps
    end
  end
end
