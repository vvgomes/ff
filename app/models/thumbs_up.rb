class ThumbsUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :accomplishment
  
  attr_accessible :user, :accomplishment
  attr_accessible :user_id, :accomplishment_id

  validates_presence_of :user
  validates_presence_of :accomplishment
  validate :user_cannot_be_poster
  validate :user_cannot_be_receiver
  validate :cannot_be_duplicated

  def user_cannot_be_poster
    return unless accomplishment
    errors.add(:user, 'cannot be poster') if user == accomplishment.poster
  end

  def user_cannot_be_receiver
    return unless accomplishment
    errors.add(:user, 'cannot be receiver') if user == accomplishment.receiver
  end

  def cannot_be_duplicated
    return unless accomplishment
    if accomplishment.thumbs_ups.find { |t| t == self }
      errors.add(:user, 'already supporting')
    end
  end

  def == other
    other.user == user && other.accomplishment == accomplishment
  end

end
