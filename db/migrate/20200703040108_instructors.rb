class Instructors < ActiveRecord::Migration[6.0]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :password_digest
      t.string :description
      t.string :cell_phone
      t.string :email
      t.boolean :admin?
    end
  end
end
