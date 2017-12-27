class Day < ActiveRecord::Base
  belongs_to :sprint
  has_many :day_tasks
  has_many :tasks, through: :day_tasks

  def as_json(options={})
    included = options[:include] || {}
    except = [:sprint, :sprint_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {day_tasks: {include: {task: {include: {project: {except: :tasks}}}}}})
    hash['points'] = points
    hash['finished_points'] = finished_points
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def points
    tasks.map(&:points).reduce(0, :+)
  end

  def finished_points
    tasks.select(&:finished).map(&:points).reduce(0, :+)
  end
end
