class Day < ActiveRecord::Base
  belongs_to :sprint
  has_many :day_tasks
  has_many :tasks, through: :day_tasks

  def as_json(options={})
    included = options[:include] || {}
    except = [:sprint, :sprint_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {tasks: {include: {project: {except: :tasks}}}})
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
