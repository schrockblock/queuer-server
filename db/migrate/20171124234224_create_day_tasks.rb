class CreateDayTasks < ActiveRecord::Migration
  def change
    create_table :day_tasks do |t|
      t.integer :day_id
      t.integer :task_id
      t.integer :next_id
      t.integer :previous_id

      t.timestamps null: false
    end
  end
end
