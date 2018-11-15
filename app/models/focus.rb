class Focus < ActiveRecord::Base
  uuid_it
  belongs_to :school
  attr_accessible :active, :name

  validates :name, presence: true, uniqueness: { scope: :school_id }

  def to_s
    self.name
  end
end
