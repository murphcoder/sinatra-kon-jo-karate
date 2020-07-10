class ChangeStudents < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.remove :age
      t.remove :grade
      t.remove :address
      t.remove :rank
    end
  end
end
