class SnapshotsController < ApplicationController
  load_resource :interaction, find_by: :uuid
  load_resource through: :interaction

  respond_to :json

  def create
    @snapshot.media = params[:media]
    @snapshot.media_file_name = 'snapshot.jpg'
    Rails.logger.info "Params: #{params}"
    Rails.logger.info "Snapshot: #{@snapshot.inspect}"
    respond_with(@snapshot) do |format|
      if @snapshot.save
        format.json { render json: @snapshot, status: :ok }
      else
        format.json { render json: @snapshot.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
end
