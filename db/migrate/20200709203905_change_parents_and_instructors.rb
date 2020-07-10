class ChangeParentsAndInstructors < ActiveRecord::Migration[6.0]
  def change
    add_column :parents, :recovery, :string
    add_column :instructors, :recovery, :string
  end
end
