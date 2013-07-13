class AddProjectToTaskAndUserToProject < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer
    add_column :tasks, :project_id, :integer
  end
end
