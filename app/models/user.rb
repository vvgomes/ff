class User < ActiveRecord::Base
  attr_accessible :name, :avatar
  validates_presence_of :name
end
