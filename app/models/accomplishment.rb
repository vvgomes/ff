class Accomplishment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  validates_presence_of :description, :poster, :receiver
  attr_accessible :description, :poster, :receiver, :poster_id, :receiver_id
end
