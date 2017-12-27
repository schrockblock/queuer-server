class AddPointsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :points, :integer, default: 1
  end
end
