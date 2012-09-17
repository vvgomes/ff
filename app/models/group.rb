class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :accomplishments
  attr_accessible :name
end
