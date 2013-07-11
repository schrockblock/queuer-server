class User < ActiveRecord::Base
  attr_accessible :admin, :password, :username
end
