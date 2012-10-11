class ThumbsUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :accomplishment
end
