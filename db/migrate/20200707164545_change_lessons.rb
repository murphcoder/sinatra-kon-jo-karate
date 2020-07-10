class ChangeLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :price, :integer
  end
end
