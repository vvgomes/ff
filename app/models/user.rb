class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'

  validates_presence_of :username
  attr_accessible :username

  devise :cas_authenticatable, :registerable, :trackable

  def email
    "#{username}@thoughtworks.com"
  end

  def report_accomplishment(user, description)
    Accomplishment.new(poster: self, receiver: user, description: description).tap(&:save)
  end
end