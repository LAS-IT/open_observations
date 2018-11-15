class Interaction < ActiveRecord::Base
  uuid_it

  has_many :snapshots, dependent: :destroy

  belongs_to :observation, counter_cache: true
  attr_accessible :grouping, :minute, :note, :on_task, :students, :teacher, :topic, :using_technology, :observation_id

  OBSERVATIONS = [:teacher, :students, :grouping, :topic]
  TEACHER_CODE_PRIORITY = [:presenting, :circulating, :answering, :discussing, :reading_writing, :listening, :other]
  STUDENTS_CODE_PRIORITY = [:presenting, :circulating, :answering, :discussing, :reading_writing, :listening, :other]
  GROUPING_CODE_PRIORITY = [:individual, :pair, :small_group, :whole_group, :fluid, :other_group]
  TOPIC_CODE_PRIORITY = [:course_content, :rapport, :management, :discipline, :other_topic]
  CODE_KEYS = {
    presenting: 'P',
    circulating: 'C',
    answering: 'A',
    discussing: 'D',
    reading_writing: 'RW',
    listening: 'L',
    other: 'O',
    individual: 'i',
    pair: 'p',
    small_group: 's',
    whole_group: 'w',
    fluid: 'f',
    other_grouping: 'o',
    course_content: 'cc',
    rapport: 'rs',
    management: 'm',
    discipline: 'd',
    other_group: 'o',
    other_topic: 'o',
  }

  bitmask :teacher, as: [:presenting, :circulating, :answering, :discussing, :reading_writing, :listening, :other], zero_value: '0'
  bitmask :students, as: [:presenting, :circulating, :answering, :discussing, :reading_writing, :listening, :other], zero_value: '0'
  bitmask :grouping, as: [:individual, :pair, :small_group, :whole_group, :fluid, :other_group], zero_value: '0'
  bitmask :topic, as: [:course_content, :rapport, :management, :discipline, :other_topic], zero_value: '0'

  scope :in_order, ->() { order("interactions.minute ASC") }

  validates_presence_of :teacher, :students, :grouping, :topic, :observation_id
  validates :minute, uniqueness: { scope: :observation_id }

  def code_string(options={})
    options[:full] ||= false
    OBSERVATIONS.reduce("") do |code_string, observation|
      code_string += send("#{observation}_code", options)
    end
  end

  OBSERVATIONS.each do |observation|
    define_method "#{observation}_code" do |options={}|
      options[:full] ||= false
      code = reorder(observation).collect { |c| code_key(c) }
      options[:full] ? code.join : code.first
    end
  end

  def as_json(options=nil)
    self.attributes.merge( {code_string: code_string, uuid: self.uuid} )
  end

  # private
  def reorder(code)
    Interaction.reorder(code, send(code))
  end

  def code_key(query)
    query.is_a?(Symbol) ? CODE_KEYS[query] : CODE_KEYS.key(query)
  end

  def self.reorder(type, codes)
    priority = case type
      when :teacher
        TEACHER_CODE_PRIORITY
      when :students
        STUDENTS_CODE_PRIORITY
      when :grouping
        GROUPING_CODE_PRIORITY
      when :topic
        TOPIC_CODE_PRIORITY
    end
    codes.sort_by do |element|
      priority.index(element)
    end
  end

end
