class AddPointsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :points, :integer, default: 0
    add_column :projects, :remaining_points, :integer, default: 0
  end
end
