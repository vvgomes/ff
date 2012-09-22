class Scope < ActiveRecord::Base
  has_many :accomplishments
  validates_presence_of :name
  attr_accessible :name
end
