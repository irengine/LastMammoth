class Yat::QueryController < Yat::SecurityController
  layout 'yat'

  def index
  end

  def group(id=params[:node])
    respond_to do |format|
      format.html # render static index.html.erb
      format.json { render :json => Group.find_children(id) }
    end
  end

  def limit_group(id=params[:node])
    current_user = User.find_by_id(session[:user_id])

    if current_user.default_group.nil?
      current_group = Group.root
    else
      current_group =current_user.default_group
    end

    if id.to_i == 0
      limit_groups = [Group.find_by_id(current_group.id)]
    else
      limit_groups = Group.find_children(id)
    end

    respond_to do |format|
      format.html # render static index.html.erb
      format.json { render :json => limit_groups }
    end
  end

  def dummy

  end
end