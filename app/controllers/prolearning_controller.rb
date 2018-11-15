class ProlearningController < ApplicationController
  layout 'prolearning'
  before_filter :authenticate_user!
  load_and_authorize_resource :school, singleton: true, through: :current_user, find_by: :uuid
  respond_to :html, :js, :json 

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, notice: exception.message
  end

  def create
    parent_id = params.keys.detect { |k| k =~ /\_id/ }
    parent_object = self.instance_variable_get("@#{parent_id.gsub(/\_id/,'')}") if parent_id.present?
    object = self.instance_variable_get("@#{self.controller_name.singularize}")
    @controller_parent_object = parent_object
    @controller_object = object
    respond_with(object) do |format|
      if object.save
        flash[:notice] = t('admin.create.success', model: flash_model)
        format.html do
          if parent_id.present?
            redirect_to [parent_object, object]
          else
            redirect_to polymorphic_path(object.class)
          end
        end
        format.json {
          render json: object, status: :created
        }
      else
        format.html { render action: 'new', alert: t('admin.create.failure', model: flash_model ) }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end 

  def update
    parent_id = params.keys.detect { |k| k =~ /\_id/ }
    parent_object = self.instance_variable_get("@#{parent_id.gsub(/\_id/,'')}") if parent_id.present?
    object = self.instance_variable_get("@#{self.controller_name.singularize}")
    @controller_parent_object = parent_object
    @controller_object = object
    respond_with(object) do |format|
      if object.update_attributes(params["#{self.controller_name.singularize}".to_sym])
        flash[:notice] = t('admin.update.success', model: flash_model)
        format.html do
          if parent_id.present?
            redirect_to [parent_object, object]
          else
            redirect_to object
          end
        end
        format.json { head :no_content }
      else
        format.html { render action: 'new', alert: t('admin.update.failure', model: flash_model ) }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent_id = params.keys.detect { |k| k =~ /\_id/ }
    parent_object = self.instance_variable_get("@#{parent_id.gsub(/\_id/,'')}") if parent_id.present?
    object = self.instance_variable_get("@#{self.controller_name.singularize}")
    object.destroy
    respond_with(object) do |format|
      if object.destroyed?
        flash[:notice] = t('admin.deleted.success', model: flash_model)
      else
        flash[:alert] = t('admin.deleted.failure', model: flash_model)
      end
      if parent_id.present?
        format.html { redirect_to parent_object }
      else
        format.html { redirect_to send("#{self.controller_name}_path") }
      end
    end
  end

  def flash_model
    t("activerecord.models.#{self.controller_name.singularize}")
  end  

  def school
    @current_school = current_user.school
    @current_school
  end

  class << self
    def table_headers(headers, options={})
      Rails.logger.info("*** HEADERS: #{headers.inspect}")
    end
  end

end
