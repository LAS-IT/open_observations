class Program < ActiveRecord::Base
  uuid_it

  belongs_to :school
  has_many :departments, dependent: :nullify

  attr_accessible :courses_count, :title
  validates :title, presence: true, uniqueness: { scope: :school_id }

  scope :by_title, ->() { order("title ASC") }

  def to_s
    title
  end 

end
