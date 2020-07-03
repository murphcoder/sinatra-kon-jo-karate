class Students < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.belongs_to :parent
      t.string :name
      t.integer :age
      t.integer :grade
      t.string :address
      t.string :rank
    end
  end
end
