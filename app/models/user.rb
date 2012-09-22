class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'
  has_and_belongs_to_many :groups

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
end
