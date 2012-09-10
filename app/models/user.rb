class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'

  attr_accessible :username, :email

  devise :cas_authenticatable, :registerable, :trackable

  def report_accomplishment_for(user, description)
    Accomplishment.new(:poster => self, :receiver => user, :description => description).tap(&:save)
  end
end