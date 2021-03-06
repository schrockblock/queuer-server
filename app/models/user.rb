class User < ActiveRecord::Base
  has_secure_password

  has_many :sprints, dependent: :destroy
  has_many :projects, :dependent => :destroy

  validates :username, :presence => true, :uniqueness => true

  before_create :set_api_key

  def as_json(options={})
    included = options[:include] || {}
    except = [:password, :password_digest, :api_key, :admin].delete_if { |attr| included.include?(attr) }

    hash = super(:except => except)
    hash['errors'] = errors.as_json if errors.present?

    hash
  end

  def set_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
