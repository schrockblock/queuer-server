class Sprint < ActiveRecord::Base
  belongs_to :user
  has_many :days
  has_many :sprint_projects
  has_many :projects, through: :sprint_projects

  def as_json(options={})
    included = options[:include] || {}
    except = [:user, :user_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: [{ projects: {except: :tasks} }, 
                                           { days: {except: [:tasks, :day_tasks]} }])
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
