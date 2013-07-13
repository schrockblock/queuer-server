class Task < ActiveRecord::Base
  attr_accessible :finished, :name, :order, :project_id, :project

  belongs_to :project, :foreign_key => :project_id, :classname => 'Project'

  def as_json(options={})
    included = options[:include] || {}
    except = [:project, :project_id].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
