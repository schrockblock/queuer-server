class CreateSprintProjectTasks < ActiveRecord::Migration
  def change
    create_table :sprint_project_tasks do |t|
      t.integer :sprint_id
      t.integer :project_id
      t.integer :task_id

      t.timestamps null: false
    end
  end
end
