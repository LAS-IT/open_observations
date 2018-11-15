class InteractionsController < ProlearningController
  load_and_authorize_resource :observation, through: :school, find_by: :uuid
  load_and_authorize_resource through: :observation, shallow: true, find_by: :uuid

  def edit_block
    start = params[:block].to_i*5-5
    range = (start..start+4)
    @interactions = @observation.interactions.in_order.select { |interaction| interaction.minute.between?(range.first,range.last) }
  end

  def summarize
    @observation_summary = ObservationSummary.new(@observation)
    from = params[:from].to_i
    to = params[:to].to_i
    respond_with(@observation_summary) do |format|
      format.json do
        render json: {
          range: "#{params[:from]} - #{params[:to]}",
          code_string: @observation_summary.summary_code_string(from: from, to: to),
          on_task: @observation_summary.on_task(from: from, to: to),
          using_technology: @observation_summary.using_technology?(from: from, to: to),
          uuid: @observation_summary.interactions.select { |i| i.minute.eql? from }.first.uuid
        }
      end
    end
  end
end
