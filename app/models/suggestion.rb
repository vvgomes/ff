class Suggestion < ActiveRecord::Base
  belongs_to :sender, :class_name => User
  belongs_to :receiver, :class_name => User

  attr_accessible :sender, :receiver
  attr_accessible :sender_id, :receiver_id
  attr_accessible :description, :useful

  validates_presence_of :description, :if => lambda { |s| !s.id }
  validates_presence_of :sender, :receiver
  validate :sender_cannot_be_receiver

  def sender_cannot_be_receiver
    errors.add(:receiver, 'cannot be yourself') if sender == receiver
  end

  def description
    @description
  end

  def description= value
    @description = value
  end
end
