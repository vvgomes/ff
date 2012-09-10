class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'

  validates_presence_of :username
  attr_accessible :username, :email, :name

  devise :cas_authenticatable, :registerable, :trackable

  def initialize(attributes=nil)
    super(attributes)
    self.name ||= self.username
  end

  def report_accomplishment_for(user, description)
    Accomplishment.new(:poster => self, :receiver => user, :description => description).tap(&:save)
  end
end