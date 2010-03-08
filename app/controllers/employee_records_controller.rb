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
end
