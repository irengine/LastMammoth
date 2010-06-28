class EmployeesController < SecurityController
  def index
    @employees = Employee.paginate :page => params[:page], :order => 'employee_number', :conditions => group_condition
  end

  def search
    @employees = Employee.in_group(@current_group)
  end
  
  def new
    @employee = Employee.new()
    @working_experience = WorkingExperience.new
    @working_experiences = []
    5.times {
      w = WorkingExperience.new
      w.begin_date = Date.today
      w.end_date = Date.today
      @working_experiences << w
    }
  end
  
  def create
    @working_experiences = []

    params[:working_experience].each do |k, v|
      @working_experiences << WorkingExperience.new(params[:working_experience][k]) unless v[:company_name].empty? and v[:job_title].empty?
    end
    
    photo_file = params[:employee].delete(:photo_file)
    @employee = Employee.new(params[:employee])
    @employee.default_group = @current_group
    @photo = Photo.new(:uploaded_data => photo_file) unless photo_file.blank?

    if Employee.create_employee(@employee, @photo, @working_experiences)
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "new"
    else
      (5-@working_experiences.length).times {
        w = WorkingExperience.new
        w.begin_date = Date.today
        w.end_date = Date.today
        @working_experiences << w
      }
      render :action => 'new'
    end
  end
  
  def edit
    @employee = Employee.find(params[:id])
    @is_editable = is_editable
    @working_experience = WorkingExperience.new
    @working_experiences = []
    @working_experiences += @employee.working_experiences
    (5 - @working_experiences.length).times {
      w = WorkingExperience.new
      w.begin_date = Date.today
      w.end_date = Date.today
      @working_experiences << w
    }
  end

  def update
    @working_experiences = []

    params[:working_experience].each do |k, v|
      @working_experiences << WorkingExperience.new(params[:working_experience][k]) unless v[:company_name].empty? and v[:job_title].empty?
    end
    @employee = Employee.find(params[:id])

    if Employee.update_employee(params[:employee], @employee, @working_experiences)
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      (5-@working_experiences.length).times {
        w = WorkingExperience.new
        w.begin_date = Date.today
        w.end_date = Date.today
        @working_experiences << w
      }
      render :action => 'edit'
    end
  end

  def photo
    @employee = Employee.find(params[:id])
    @is_editable = is_editable
   end

  def upload
    @employee = Employee.find(params[:id])
    @photo = Photo.new(:uploaded_data => params[:photo_file]) unless params[:photo_file].blank?

    if Employee.upload_photo(@employee, @photo)
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "index"
    else
      render :action => 'photo'
    end
  end

  def asset
    name = params[:id]
    sql = CustomQueryGenerator.generate_sql(name, params[:search])
    @result = ActiveRecord::Base.connection.execute(sql)
  end

  private

  def is_editable
    if @current_group.eql?(Group.root)
      return true
    end

    if !@employee.status.nil? && @employee.status.group.eql?(@employee.status.branch.external)
      return true
    end

    if @current_group.eql?(@employee.default_group)
      return true
    end

    return false
  end

  def group_condition
    if @current_group == Group.root
      '1=1'
    else
      "default_group_id = #{@current_group.id}"
    end
  end
end
