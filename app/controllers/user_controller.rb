class UserController < SecurityController
  def list_permissions
    @users = User.find(:all, :order => "name")
    @roles = Role.find(:all, :order => "name")
  end

  def update_permissions
    Permission.transaction do
      Permission.delete_all
      for user in User.find(:all)
        for role in Role.find(:all)
          if params[:permission]["#{user.id}-#{role.id}"] == "on"
            Permission.create(:user_id => user.id, :role_id => role.id)
          end
        end
      end
    end
    flash[:notice] = I18n.t("userform_Update")
    redirect_to :action => "list_permissions"
  end
end
