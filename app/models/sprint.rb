class Sprint < ActiveRecord::Base
  belongs_to :user
  has_many :days
  has_many :sprint_projects
  has_many :projects, through: :sprint_projects

  def as_json(options={})
    included = options[:include] || {}
    excepted = options[:except] || {}
    except = [:user, :user_id, :projects, :days].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: { sprint_projects: {include: {project: {except: :tasks}, 
                                                                       sprint_project_tasks: {include: {task: {except: :project}}}}},
                                            days: { except: [:tasks, :day_tasks]} })
    
    hash['points'] = points
    hash['finished_points'] = finished_points
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def points
    days.map(&:points).reduce(0, :+)
  end

  def finished_points
    days.map(&:finished_points).reduce(0, :+)
  end
end
