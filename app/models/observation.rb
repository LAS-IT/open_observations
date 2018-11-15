class Observation < ActiveRecord::Base
  uuid_it

  belongs_to :course
  belongs_to :teacher
  belongs_to :user

  has_many :interactions, dependent: :nullify
  accepts_nested_attributes_for :interactions

  attr_accessible :feedback, :number_of_students, :observed_on,
    :observer_confidence, :period, :course_id, :teacher_id, :user_id,
    :interactions_attributes

  validates :course_id, presence: true
  validates :teacher_id, presence: true
  validates :user_id, presence: true
  validates :observed_on, presence: true
  validates :number_of_students, numericality: { only_integer: true, greater_than: 0 }
  validate :only_complete_observations_can_have_confidence

  scope :most_recent, ->() { order("observations.observed_on DESC") }
  scope :completed, ->() { where(interactions_count: 40) }
  scope :not_completed, ->() { where("NOT interactions_count = 40") }
  scope :observed_by, ->(observer) { where(user_id: observer.id) }

  def observation_recorded?
    self.interactions.count.eql? 40    
  end

  def confident!
    self.update_attributes observer_confidence: true 
  end

  def not_confident!
    self.update_attributes observer_confidence: false
  end

  def to_s
    self.inspect
    "#{observed_on.to_s(:rfc822)} Observation"
  end

  private
  def only_complete_observations_can_have_confidence
    errors.add :observer_confidence, 'cannot be true for an incomplete observation' if observer_confidence.eql?(true) && !observation_recorded?
  end

end
