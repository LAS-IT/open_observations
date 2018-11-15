class ObservationSummary
  attr_accessor :interactions
  attr_accessor :observation

  def initialize(observation, interactions: nil)
    @observation = observation
    @interactions = interactions.nil? ? observation.interactions : []
  end

  def summary_code_string(from: nil, to: nil, options: nil)
    options ||= {}
    raise ArgumentError, 'Provide a starting minute' if from.nil?    
    raise ArgumentError, 'Provide an ending minute' if to.nil?    
    codes = []
    codes << teacher_code(from: from, to: to, options: options)
    codes << students_code(from: from, to: to, options: options)
    codes << grouping_code(from: from, to: to, options: options)
    codes << topic_code(from: from, to: to, options: options)
    codes.join
  end

  def code_string_counts
    codes = []
    (0...40).step 5 do |starting|
      codes << self.summary_code_string(from: starting, to: starting+4)
    end
    codes
  end

  def teacher_code(from: nil, to: nil, options: {})
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) } 
    codes = interaction_set.collect do |interaction|
      interaction.teacher
    end.flatten!
    codes = Interaction.reorder(:teacher, codes)
    most_frequent = codes.max_by { |code| codes.count(code) }
    Interaction::CODE_KEYS[most_frequent]
  end

  def teacher_counts
    all_codes = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      codes = interaction_set.collect { |interaction| interaction.teacher }.flatten!
      codes = Interaction.reorder(:teacher, codes)
      all_codes << codes.max_by { |code| codes.count(code) }
    end
    all_codes.each_with_object(Hash.new(0)) { |code, count| count[code.to_s.titleize] += 1 }
  end

  def students_code(from: nil, to: nil, options: {})
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) } 
    codes = interaction_set.collect do |interaction|
      interaction.students
    end.flatten!
    codes = Interaction.reorder(:students, codes)
    most_frequent = codes.max_by { |code| codes.count(code) }
    Interaction::CODE_KEYS[most_frequent]
  end

  def students_counts
    all_codes = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      codes = interaction_set.collect { |interaction| interaction.students }.flatten!
      codes = Interaction.reorder(:students, codes)
      all_codes << codes.max_by { |code| codes.count(code) }
    end
    all_codes.each_with_object(Hash.new(0)) { |code, count| count[code.to_s.titleize] += 1 }
  end

  def grouping_code(from: nil, to: nil, options: {})
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) } 
    codes = interaction_set.collect do |interaction|
      interaction.grouping
    end.flatten!
    codes = Interaction.reorder(:grouping, codes)
    most_frequent = codes.max_by { |code| codes.count(code) }
    Interaction::CODE_KEYS[most_frequent]
  end

  def grouping_counts
    all_codes = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      codes = interaction_set.collect { |interaction| interaction.grouping }.flatten!
      codes = Interaction.reorder(:grouping, codes)
      all_codes << codes.max_by { |code| codes.count(code) }
    end
    all_codes.each_with_object(Hash.new(0)) { |code, count| count[code.to_s.titleize] += 1 }
  end

  def topic_code(from: nil, to: nil, options: {})
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) } 
    codes = interaction_set.collect do |interaction|
      interaction.topic
    end.flatten!
    codes = Interaction.reorder(:topic, codes)
    most_frequent = codes.max_by { |code| codes.count(code) }
    Interaction::CODE_KEYS[most_frequent]
  end

  def topic_counts
    all_codes = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      codes = interaction_set.collect { |interaction| interaction.topic }.flatten!
      codes = Interaction.reorder(:topic, codes)
      all_codes << codes.max_by { |code| codes.count(code) }
    end
    all_codes.each_with_object(Hash.new(0)) { |code, count| count[code.to_s.titleize] += 1 }
  end

  def using_technology?(from: nil, to: nil)
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) }
    tech_usage = interaction_set.collect(&:using_technology)
    tech_usage.max_by { |using_tech| tech_usage.count(using_tech) }
  end

  def using_technology_counts
    all_tech = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      tech = interaction_set.collect(&:using_technology?)
      all_tech << tech.max_by { |t| tech.count(t) }
    end
    all_tech.each_with_object(Hash.new(0)) { |tech, count| count[:"#{(tech ? 'Yes' : 'No')}"] += 1 }  
  end

  def on_task(from: nil, to: nil)
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) }
    on_tasks = interaction_set.collect(&:on_task)
    on_tasks.max_by { |on_task| on_tasks.count(on_task) }
  end

  def on_task_counts
    on_tasks = []
    (0..39).to_a.in_groups_of(5) do |block|
      interaction_set = self.interactions.select { |interaction| interaction.minute.between?(block.first, block.last) }
      tasks = interaction_set.collect(&:on_task)
      on_tasks << tasks.max_by { |t| tasks.count(t) }
    end
    on_tasks.each_with_object(Hash.new(0)) { |task, count| count[:"#{task}"] += 1 }  
  end

  def snapshots(from: nil, to: nil)
    interaction_set = self.interactions.select { |interaction| interaction.minute.between?(from, to) }
    interaction_set.collect(&:snapshots).flatten
  end
end
