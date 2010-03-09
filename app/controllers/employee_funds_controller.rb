class EmployeeFundsController < SecurityController
  def index
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_funds = EmployeeFund.find(:all, :conditions => ["employee_id = ?", session[:employee_id]])
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employee_funds'
    end
  end

  def new
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_fund = EmployeeFund.new
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employee_funds'
    end
  end

  def create
    @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
    @employee_fund = EmployeeFund.new(params[:employee_fund])
    @employee_fund.employee = @employee

    if @employee_fund.save
      flash[:notice] = '创建缴金记录成功.'
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end

  def edit
    @employee_fund =EmployeeFund.find_by_id(params[:id])
    @employee = @employee_fund.employee
  end

  def update
    @employee_fund =EmployeeFund.find_by_id(params[:id])
    @employee_fund.update_attributes(params[:employee_fund])
    if @employee_fund.save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      @employee = @employee_fund.employee
      render :action => 'edit'
    end
  end
end
