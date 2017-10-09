class Task < ActiveRecord::Base

  belongs_to :project

  def as_json(options={})
    included = options[:include] || {}
    except = [:project, :project_id].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
