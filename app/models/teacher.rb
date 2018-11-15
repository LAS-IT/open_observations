class Teacher < ActiveRecord::Base
  uuid_it

  belongs_to :school
  belongs_to :user
  has_many :courses, dependent: :nullify

  attr_accessible :first_name, :last_name, :registration_code, :school_id
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :school_id, presence: true
  validates :registration_code, uniqueness: { scope: :school_id }
  before_validation :generate_registration_code

  scope :by_last_name, ->() { order("teachers.last_name ASC") }

  def to_s
    "#{first_name} #{last_name}"
  end

  private
  def generate_registration_code
    write_attribute(:registration_code, SecureRandom.hex[0..7].upcase)
  end
end
