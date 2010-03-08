class SiteContractsController < SecurityController
  def index
    @groups = @current_group.full_set()
  end

  def show
    if params[:site_id]
      session[:site_id] = params[:site_id]
    end
    if session[:site_id]
      @site = Group.find(:first, :conditions => ["id = ?", session[:site_id]])
      @site_contracts = SiteContract.find(:all, :conditions => ["site_id = ?", session[:site_id]])
    else
      flash[:notice] = '请选择驻点.'
      redirect_to :action => 'index'
    end
  end

  def new
    if params[:site_id]
      session[:site_id] = params[:site_id]
    end
    if session[:site_id]
      @site = Group.find(:first, :conditions => ["id = ?", session[:site_id]])
      @site_contract = SiteContract.new
    else
      flash[:notice] = '请选择驻点.'
      redirect_to :action => 'index'
    end
  end

  def create
    @site = Group.find(:first, :conditions => ["id = ?", session[:site_id]])
    @site_contract = SiteContract.new(params[:site_contract])
    @site_contract.site = @site

    if @site_contract.save
      flash[:notice] = '创建驻点合同成功.'
      redirect_to :action => "show"
    else
      render :action => 'new'
    end
  end

  def edit
    @site_contract = SiteContract.find(params[:id])
    @site = @site_contract.site
  end

  def update
    @site_contract = SiteContract.find(params[:id])
    @site = @site_contract.site

    if @site_contract.update_attributes(params[:site_contract])
      flash[:notice] = "修改驻点合同成功"
      redirect_to :action => "show"
    else
      render :action => 'edit'
    end
  end
end
