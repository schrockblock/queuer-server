class AddPointsToDay < ActiveRecord::Migration
  def change
    add_column :days, :points, :integer, default: 0
    add_column :days, :finished_points, :integer, default: 0
  end
end
