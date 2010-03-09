class RoleController < SecurityController
  def list_entries
    @roles = Role.find(:all, :order => "name")
    @features = Feature.find(:all, :order => "level")
  end

  def update_entries
    Entry.transaction do
      Entry.delete_all
      for role in Role.find(:all)
        for feature in Feature.find(:all)
          if params[:entry]["#{role.id}-#{feature.id}"] == "on"
            Entry.create(:role_id => role.id, :feature_id => feature.id)
          end
        end
      end
    end
    flash[:notice] = I18n.t("roleform_Update")
    redirect_to :action => "list_entries"
  end
end
