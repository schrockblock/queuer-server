class AddPointsToSprintProjects < ActiveRecord::Migration
  def change
    add_column :sprint_projects, :points, :integer
    add_column :sprint_projects, :remaining_points, :integer
  end
end
