class Suggestion < ActiveRecord::Base
  belongs_to :sender, :class_name => User
  belongs_to :receiver, :class_name => User

  attr_accessible :description, :sender, :receiver
  attr_accessible :sender_id, :receiver_id

  validates_presence_of :description, :sender, :receiver
end
