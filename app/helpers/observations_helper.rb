module ObservationsHelper
  def new_observation?(observation=@observation)
    !@observation.observation_recorded?
  end
end
