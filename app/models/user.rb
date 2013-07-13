class User < ActiveRecord::Base
  has_secure_password

  include TokenGenerator

  has_many :projects, :dependent => :destroy
  has_many :tasks, :through => :projects

  validates :username, :presence => true, :uniqueness => true

  before_create { generate_token(:api_key) }

  attr_accessible :admin, :password, :username

  def as_json(options={})
    included = options[:include] || {}
    except = [:password_digest, :api_key, :admin].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end
end
