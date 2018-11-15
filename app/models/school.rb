class School < ActiveRecord::Base
  uuid_it
  validates_presence_of :name, :town, :country
  validates_uniqueness_of :teacher_code, :observer_code, allow_blank: true
  attr_accessible :country, :deleted_at, :name, :town

  before_validation :generate_code

  has_many :programs, dependent: :nullify
  has_many :departments, through: :programs
  has_many :courses, through: :departments
  has_many :teachers, dependent: :nullify
  has_many :observations, through: :courses

  has_many :focuses, dependent: :nullify
  has_many :users, dependent: :nullify

  def to_s
    self.name
  end

  def teacher_code
    write_attribute(:teacher_code, random_string) if self[:teacher_code].blank?
    self[:teacher_code] 
  end

  def observer_code
    write_attribute(:observer_code, random_string) if self[:teacher_code].blank?
    self[:observer_code] 
  end

  protected
  def generate_code(attributes=nil)
    attributes ||= [:teacher_code, :observer_code]
    Array(attributes).each do |attribute|
      write_attribute(attribute, random_string)
    end 
  end
  def random_string
    SecureRandom.hex[0..7].upcase
  end
end
