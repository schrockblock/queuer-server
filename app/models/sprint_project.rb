class SprintProject < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :project
  has_many :sprint_project_tasks, dependent: :destroy
  has_many :tasks, through: :sprint_project_tasks

  validates :project_id, uniqueness: { scope: :sprint_id }

  def as_json(options={})
    included = options[:include] || {}
    except = [:sprint].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {project: {except: :tasks}, tasks: {except: :project}})
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def update_points
    self.points = calculate_points
    self.remaining_points = calculate_remaining_points

    save
  end

  def calculate_points
    sprint_project_tasks.map(&:task).map(&:points).reduce(0, :+)
  end

  def calculate_remaining_points
    points - sprint_project_tasks.map(&:task).select(&:finished).map(&:points).reduce(0, :+)
  end

end
