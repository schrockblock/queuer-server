class SprintProject < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :project

  def as_json(options={})
    included = options[:include] || {}
    except = [:sprint, :sprint_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {project: {except: :tasks}})
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
