class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => Accomplishment
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => Accomplishment

  has_many :sent_suggestions, :foreign_key => 'sender_id', :class_name => Suggestion
  has_many :received_suggestions, :foreign_key => 'receiver_id', :class_name => Suggestion

  attr_accessible :username
  validates_presence_of :username

  devise :cas_authenticatable, :registerable, :trackable

  def email
    "#{username}@thoughtworks.com"
  end

  def report_accomplishment(description, receiver, scope)
    Accomplishment.new({
      :description => description,
      :poster => self,
      :receiver => receiver,
      :scope => scope
    }).tap(&:save)
  end

  def peers
    User.all - [self]
  end

  def accomplishments_for scope
    accomplishments.select{ |a| a.scope == scope }
  end

  def latest_accomplishments
    accomplishments.sort { |x, y| y.created_at <=> x.created_at }
  end

  def suggest(description, receiver)
    Suggestion.new({
      :description => description,
      :sender => self,
      :receiver => receiver
    }).tap(&:save)
  end
end
