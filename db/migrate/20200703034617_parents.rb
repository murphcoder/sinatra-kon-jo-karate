class Parents < ActiveRecord::Migration[6.0]
  def change
    create_table :parents do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :password_digest
      t.string :cell_phone
    end
  end
end
