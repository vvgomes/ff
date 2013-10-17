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

  def fans
    User.connection.execute("
      select users.id from users, accomplishments 
      where accomplishments.receiver_id = #{id} 
      and accomplishments.poster_id = users.id 
      group by users.id order by count(users.id) desc limit 3
    ").values.flatten.map{ |id| User.find(id) }
  end

  def idols
    User.connection.execute("
      select users.id from users, accomplishments 
      where accomplishments.poster_id = #{id} 
      and accomplishments.receiver_id = users.id 
      group by users.id order by count(users.id) desc limit 3
    ").values.flatten.map{ |id| User.find(id) }
  end

  def received_plus_ones
    PlusOne.where(:accomplishment_id => Accomplishment.where(:receiver_id=>id))
  end

  def accomplishment_trends
    counts = 12.times.inject({}){ |h, n| h.merge(n.months.ago.strftime('%b')=> 0) }
    accomplishments.latest.limit(12).each do |a|
      counts[a.created_at.strftime('%b')] += 1
    end
    counts.to_a.reverse
  end

  def post_trends
    counts = 12.times.inject({}){ |h, n| h.merge(n.months.ago.strftime('%b')=> 0) }
    posts.latest.limit(12).each do |a|
      counts[a.created_at.strftime('%b')] += 1
    end
    counts.to_a.reverse
  end

  def tag_counts
    accomplishments.map(&:tag_list).flatten.uniq.inject({}) do |h, tag|
      h.merge(tag => accomplishments.tagged_with(tag).count)
    end.to_a
  end
end

