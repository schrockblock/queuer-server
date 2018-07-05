class Sprint < ActiveRecord::Base
  belongs_to :user
  has_many :days
  has_many :sprint_projects
  has_many :projects, through: :sprint_projects

  def as_json(options={})
    included = options[:include] || {}
    excepted = options[:except] || {}
    except = [:user, :user_id, :projects, :days].delete_if { |attr| included.include?(attr) }

    hash = super(except: except)

    unless excepted.include?(:projects)
      projects_json = projects.as_json(except: :tasks)
      hash['projects'] = projects_json
    end

    unless excepted.include? :days
      days_json = days.as_json(except: [:tasks, :day_tasks])
      hash['days'] = days_json
    end
    
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
