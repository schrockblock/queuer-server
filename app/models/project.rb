class Project < ActiveRecord::Base
  attr_accessible :color, :name, :user_id, :user

  has_many :tasks

  belongs_to :user, :foreign_key => :user_id, :classname => 'User'

  def as_json(options={})
    included = options[:include] || {}
    except = [:user, :user_id].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
