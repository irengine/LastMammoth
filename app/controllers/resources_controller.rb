class ResourcesController < SecurityController
  before_filter :get_scope

  CODE_SCOPES = [
    "political_status",
    "educational_attainments",
    "person_type",
    "employee_type",
    "fund_type",
    "fund_address",
    "training_status"
  ]

  def index
    @resources = Resource.codes(@code_scope)
  end

  def new
      @resource = Resource.new
  end

  def create
    @resource = Resource.new(params[:resource])
    @resource.scope = Resource.to_code(session[:code_scope])

    if @resource.save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])

    if @resource.update_attributes(params[:resource])
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.mode = 'inactive'

    if @resource.save
      flash[:notice] = I18n.t("action_Delete_Success")
      redirect_to :action => "index"
    else
      render :action => 'index'
    end
  end

  private

  def get_scope
    if params[:code_scope]
      session[:code_scope] = params[:code_scope]
    end

    if !session[:code_scope]
      session[:code_scope] = CODE_SCOPES[0]
    end
    @code_scope = session[:code_scope]
  end
end
