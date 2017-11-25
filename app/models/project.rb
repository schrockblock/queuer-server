class Project < ActiveRecord::Base

  has_many :tasks

  belongs_to :user

  def as_json(options={})
    included = options[:include] || {}
    except = [:user, :user_id].delete_if { |attr| included.include?(attr) }

    hash = super(except: except, include: {tasks: {except: :project}})
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
