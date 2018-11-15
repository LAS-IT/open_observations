class UsersController < ProlearningController
  load_and_authorize_resource through: :school, find_by: :uuid
  before_filter :populate_available_roles, only: [:new, :add, :edit, :update]

  def add
    @user = @school.users.build(params[:user])
    respond_with(@user) do |format|
      if @user.save
        format.html { redirect_to @user, notice: t('admin.create.success', model: 'Account') }
      else
        format.html { render action: 'new', alert: t('admin.create.failure', model: 'Account') }
      end
    end
  end

  private
  def populate_available_roles
    @available_roles = if current_user.has_role?(:admin)
      Role.by_name.collect do |role|
        [role.name.titleize, role.id]
      end
    elsif current_user.has_role?(:manager)
      Role.for_manager.by_name.collect do |role|
        [role.name.titleize, role.id]
      end
    else
      []
    end
  end
end
