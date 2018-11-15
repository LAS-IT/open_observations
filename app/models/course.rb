class Course < ActiveRecord::Base
  SEMESTERS = %w|First Second Summer|
  uuid_it

  belongs_to :teacher
  belongs_to :department, counter_cache: true

  has_many :observations, dependent: :nullify

  attr_accessible :description, :name, :section, :semester, :department_id, :teacher_id, :teacher_attributes

  validates :name, presence: true
  validates :section, uniqueness: { scope: [:department_id, :semester] }
  validates :semester, inclusion: { in: SEMESTERS }

  accepts_nested_attributes_for :teacher, reject_if: proc { |attributes| attributes['first_name'].blank? }

  scope :by_name, ->() { order("courses.name ASC") }

  def to_s
    self.name
  end
end
