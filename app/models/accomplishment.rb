class Accomplishment < ActiveRecord::Base
  belongs_to :poster, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :scope
  
  attr_accessible :description, :poster, :receiver, :scope
  attr_accessible :poster_id, :receiver_id, :scope_id

  validates_presence_of :description, :poster, :receiver, :scope
  validate :poster_cannot_be_receiver
 
  def poster_cannot_be_receiver
    errors.add(:receiver, 'cannot be yourself') if poster == receiver
  end

  def self.latest
    order 'created_at DESC'
  end
end
