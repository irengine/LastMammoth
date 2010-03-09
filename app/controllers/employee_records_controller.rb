class EmployeeRecordsController < SecurityController
  def index
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_records = EmployeeRecord.find(:all, :conditions => ["employee_id = ?", session[:employee_id]])
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employee_records'
    end
  end

  def new
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_record = EmployeeRecord.new
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employee_records'
    end
  end

  def create
    @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
    @employee_record = EmployeeRecord.new(params[:employee_record])
    @employee_record.employee = @employee

    if @employee_record.save
      flash[:notice] = '创建奖惩记录成功.'
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end

  def edit
    @employee_record =EmployeeRecord.find_by_id(params[:id])
    @employee = @employee_record.employee
  end

  def update
    @employee_record =EmployeeRecord.find_by_id(params[:id])
    @employee_record.update_attributes(params[:employee_record])
    if @employee_record.save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      @employee = @employee_record.employee
      render :action => 'edit'
    end
  end
end
