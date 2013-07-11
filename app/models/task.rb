class Task < ActiveRecord::Base
  attr_accessible :finished, :name, :order
end
