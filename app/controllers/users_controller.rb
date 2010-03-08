class UsersController < SecurityController
  def index
    @users = User.find(:all)
    #    @users = User.all_users
  end

  def new
    @parent_groups = Group.companies
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      @parent_groups = Group.companies
      render :action => 'new'
    end
  end

  def edit
    @parent_groups = Group.companies
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      @parent_groups = Group.companies
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to :action => "index"
  end
  
  def change_password
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def update_password
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      render :action => 'edit'
    end
  end
end
