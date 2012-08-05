class Accomplishment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  attr_accessible :description, :poster, :receiver
  validates_presence_of :description, :poster, :receiver
end
