class Snapshot < ActiveRecord::Base
  belongs_to :interaction
  
  attr_accessible :interaction_id, :media, :note
  has_attached_file :media, styles: { medium: "300x300>", thumb: "100x100>" }
  validates :interaction_id, presence: true
  validates_attachment  :media, presence: true,
                        content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'video/mp4', 'video/mov'] }

  def as_json(options=nil)
    self.attributes.merge({thumb: self.media.url(:thumb)})
  end

end
