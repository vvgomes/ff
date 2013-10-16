class User < ActiveRecord::Base
  has_many :posts, 
    :foreign_key => 'poster_id', 
    :class_name => Accomplishment

  has_many :accomplishments, 
    :foreign_key => 'receiver_id', 
    :class_name => Accomplishment, 
    :order => 'created_at DESC'

  has_many :sent_suggestions, 
    :foreign_key => 'sender_id', 
    :class_name => Suggestion

  has_many :received_suggestions, 
    :foreign_key => 'receiver_id', 
    :class_name => Suggestion

  has_many :plus_ones

  attr_accessible :username
  validates_presence_of :username
  before_save { |u| u.username = u.username.downcase }

  devise :cas_authenticatable, :registerable, :trackable

  def email
    "#{username}@thoughtworks.com"
  end

  def report_accomplishment(description, receiver)
    Accomplishment.new({
      :description => description,
      :poster => self,
      :receiver => receiver
    }).tap(&:save)
  end

  def allowed_to_delete?(accomplishment)
    accomplishment.poster == self
  end

  def delete_accomplishment(acc)
    acc.destroy if allowed_to_delete? acc
  end

  def peers
    User.all - [self]
  end

  def suggest(description, receiver)
    Suggestion.new({
      :description => description,
      :sender => self,
      :receiver => receiver
    }).tap(&:save)
  end

  def score
    accomplishments.size
  end

  def allowed_to_plus_one? accomplishment
    accomplishment.poster != self &&
    accomplishment.receiver != self &&
    !accomplishment.plus_ones.map(&:user).include?(self)
  end

  def plus_one(accomplishment)
    PlusOne.new({
      :accomplishment => accomplishment,
      :user => self
    }).tap(&:save) if allowed_to_plus_one? accomplishment
  end

  def tags
    (accomplishments + posts).map(&:tag_list).flatten.uniq
  end

  def accomplishment_trends
    counts = 12.times.inject({}){ |h, n| h.merge(n.months.ago.strftime('%b')=> 0) }
    accomplishments.latest.limit(12).each do |a|
      counts[a.created_at.strftime('%b')] += 1
    end
    counts.to_a.reverse
  end
end

