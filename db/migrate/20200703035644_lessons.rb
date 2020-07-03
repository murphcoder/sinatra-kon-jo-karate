class Lessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.belongs_to :location
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
    end
  end
end
