class PlusOne < ActiveRecord::Base
  belongs_to :accomplishment
  belongs_to :user

  attr_accessible :accomplishment, :user
end
