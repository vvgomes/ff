class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :posts, :foreign_key => 'poster_id', :class_name => 'Accomplishment'
  has_many :accomplishments, :foreign_key => 'receiver_id', :class_name => 'Accomplishment'
  attr_accessible :name, :avatar
  validates_presence_of :name
end
