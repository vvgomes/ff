class Suggestion < ActiveRecord::Base
  belongs_to :sender, :class_name => User
  belongs_to :receiver, :class_name => User

  attr_accessible :sender, :receiver, :description
  attr_accessible :sender_id, :receiver_id

  validates_presence_of :description, :sender, :receiver
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
