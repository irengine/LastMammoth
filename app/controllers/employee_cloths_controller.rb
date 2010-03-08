class EmployeeClothsController < SecurityController
  def index
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_clothes = EmployeeCloth.find(:all, :conditions => ["employee_id = ?", session[:employee_id]])
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employees', :action => 'search'
    end
  end

  def new
    if params[:employee_id]
      session[:employee_id] = params[:employee_id]
    end
    if session[:employee_id]
      @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
      @employee_clothes = EmployeeCloth.new
    else
      flash[:notice] = '请选择员工.'
      redirect_to :controller => 'employees', :action => 'search'
    end
  end

  def create
    @employee = Employee.find(:first, :conditions => ["id = ?", session[:employee_id]])
    @employee_clothes = EmployeeCloth.new(params[:employee_cloth])
    @employee_clothes.employee = @employee

    if @employee_clothes.save
      flash[:notice] = '服装领用成功.'
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end
end
