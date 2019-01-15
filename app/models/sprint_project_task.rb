class SprintProjectTask < ActiveRecord::Base
  belongs_to :sprint_project
  belongs_to :task

  validates :task_id, uniqueness: { scope: :sprint_project_id }

  after_create :update_sprint_project_points
  after_destroy :update_sprint_project_points

  def as_json(options={})
    included = options[:include] || {}
    except = [:sprint_project, :sprint_project_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {task: {except: :project}})
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def update_sprint_project_points
    sprint_project.update_points
  end
end
