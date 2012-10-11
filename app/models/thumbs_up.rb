class ThumbsUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :accomplishment
  
  attr_accessible :user, :accomplishment
  attr_accessible :user_id, :accomplishment_id
end
