class Department < ActiveRecord::Base
  uuid_it

  belongs_to :program
  has_many :courses, dependent: :nullify
  has_many :teachers, through: :courses, uniq: true

  attr_accessible :courses_count, :description, :name, :program_id
  validates :name, presence: true, uniqueness: { scope: :program_id }

  scope :by_name, ->() { order("departments.name ASC") }

  def to_s
    name
  end
end
