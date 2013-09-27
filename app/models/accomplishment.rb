class Accomplishment < ActiveRecord::Base
  include Twitter::Extractor

  belongs_to :poster, :class_name => User
  belongs_to :receiver, :class_name => User
  
  attr_accessible :description, :poster, :receiver
  attr_accessible :poster_id, :receiver_id 

  acts_as_taggable

  validates_length_of :description, :maximum => 140
  validates_presence_of :description, :poster, :receiver
  validate :poster_cannot_be_receiver

  before_save :parse_tags
 
  def poster_cannot_be_receiver
    errors.add(:receiver, 'cannot be yourself') if poster == receiver
  end

  def self.latest
    order 'created_at DESC'
  end

  private

  def parse_tags
    tag_list.add(extract_hashtags(description))
  end
end
