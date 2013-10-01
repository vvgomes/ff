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
end
