class User < ActiveRecord::Base
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'

  attr_accessible :username, :email, :password, 
    :password_confirmation, :remember_me
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
end
