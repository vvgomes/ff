class Accomplishment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :group
  
  attr_accessible :description, :poster, :receiver, :group
  attr_accessible :poster_id, :receiver_id, :group_id

  validates_presence_of :description, :poster, :receiver, :group
  validates_length_of :description, :maximum => 140
  validate :poster_cannot_be_receiver
 
  def poster_cannot_be_receiver
    errors.add(:receiver, "can't be yourself") if poster == receiver
  end

  def self.latest
    order 'created_at DESC'
  end
end
