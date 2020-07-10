class Students < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.belongs_to :parent
      t.string :name
    end
  end
end
