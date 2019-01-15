class ChangeSptOwner < ActiveRecord::Migration
  def change
    remove_column :sprint_project_tasks, :project_id
    rename_column :sprint_project_tasks, :sprint_id, :sprint_project_id
  end
end
