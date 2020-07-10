class ChangeParents < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :balance, :integer
  end
end
