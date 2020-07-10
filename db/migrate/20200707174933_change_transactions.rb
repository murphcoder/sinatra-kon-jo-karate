class ChangeTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :paid?, :boolean
  end
end
