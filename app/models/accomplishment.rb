class Accomplishment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
    
  attr_accessible :description, :poster, :receiver, :poster_id, :receiver_id

  validates_presence_of :description, :poster, :receiver
  validate :poster_cannot_be_receiver
 
  def poster_cannot_be_receiver
    errors.add(:receiver, "can't be yourself") if poster == receiver
  end
end
