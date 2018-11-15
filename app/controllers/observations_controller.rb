class ObservationsController < ProlearningController
  load_and_authorize_resource :course, through: :school, find_by: :uuid
  load_and_authorize_resource through: :course, shallow: true, find_by: :uuid
  before_filter :prepare_observation, only: [:new]
  before_filter :prepare_summary, only: [:show]

  def index
    @observations = Observation.accessible_by(current_ability).includes(:course, :teacher, :user).completed.most_recent
    @incomplete_observations = Observation.accessible_by(current_ability).includes(:course, :teacher, :user).where(user_id: current_user.id).not_completed.most_recent
  end

  def record
    if @observation.interactions.blank?
      40.times do |minute|
        @observation.interactions.build(minute: minute)
      end
    end
  end

  def confident_in
    respond_with(@observation) do |format|
      if @observation.confident!
        flash[:notice] = 'Observation has observer confidence' 
      else
        flash[:alert] = @observation.errors.full_messages.to_sentence
      end
      format.html { redirect_to @observation }
    end
  end

  def start
    respond_with(@observation) do |format|
      if @observation.observation_recorded?
        format.html { redirect_to @observation, notice: 'Observation is complete' }
      else
        if @observation.interactions.any? 
          @summary = ObservationSummary.new(@observation)
          @start_minute = @observation.interactions.in_order.last.minute + 1
          minutes = @observation.interactions.in_order.collect(&:minute)
          @missing_minutes = (0..minutes.last).to_a - minutes
        else
          @start_minute = 0
          @missing_minutes = []
        end
      end
    end
  end

  def update
    if params[:recording].eql?('1')
      respond_with(@observation) do |format|
        if @observation.update_attributes(params[:observation])
          format.html { redirect_to @observation, notice: 'Successfully Recorded Observation' }
        else
          format.html { render action: 'record' }
        end
      end
    else
      super
    end
  end

  def summary
    @observation_summary = ObservationSummary.new(@observation)
    respond_with(@observation) do |format|
      format.json do
        render json: {
          range: "#{params[:from]} - #{params[:to]}"
        }
      end
    end
  end

  def summaries
    if params[:observation_ids].blank?
      redirect_to observations_path, notice: 'Unable to load summaries'
    else
      observations = Observation.order("observed_on").accessible_by(current_ability).find(params[:observation_ids])
      @observation_summaries = observations.collect { |ob| ObservationSummary.new(ob) }
      respond_with(@observations_summaries)
    end
  end 

  private
  def prepare_summary 
    @observation_summary = ObservationSummary.new(@observation) unless @observation.nil?
  end
  def prepare_observation
    @observation = if @course.present?
      @course.observations.build(observed_on: Date.today, teacher_id: @course.teacher_id, user_id: current_user.id)    
    else
      Observation.new(user_id: current_user.id)
    end
  end
end
