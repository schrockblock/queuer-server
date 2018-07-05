class Task < ActiveRecord::Base

  belongs_to :project

  after_save :update_project_points

  def as_json(options={})
    included = options[:include] || {}
    except = [:project, :project_id].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def update_project_points
    project.points = project.calculate_points
    project.remaining_points = project.calculate_remaining_points

    project.save
  end
end
