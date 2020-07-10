class Transactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :lesson
      t.belongs_to :student
      t.integer :cost
      t.timestamps
    end
  end
end
