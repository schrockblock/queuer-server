class CreateSprintProjects < ActiveRecord::Migration
  def change
    create_table :sprint_projects do |t|
      t.integer :sprint_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
