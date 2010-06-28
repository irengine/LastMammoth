class JobsController < SecurityController
  before_filter :get_branches

  def start
    @employee = Employee.find(params[:eid])
    if @employee.status.flag == "1"
      redirect_to :controller => 'data', :index => 'index'
    end
    @job = JobHistory.new
#    @branches = [@current_group]
  end

  def create_start
    @employee = Employee.find(params[:eid])
    @job = JobHistory.new(params[:job_history])
#    @branches = [@current_group]

    branch = Group.find(params[:group_filter][:branch]) unless params[:group_filter][:branch].empty?
    group = Group.find(params[:group_filter][:group]) unless params[:group_filter][:group].empty?
    team = Group.find(params[:group_filter][:site]) unless params[:group_filter][:site].empty?

    @job.employee = @employee

    @job.history_type = 'start'

    @job.source_branch = @employee.status.branch
    @job.source_group = @employee.status.group
    @job.source_team = @employee.status.team

    @job.target_branch = branch
    @job.target_group = group
    @job.target_team = team

    @employee.status.branch = branch
    @employee.status.group = group
    @employee.status.team = team
    @employee.status.flag = 1

    @employee.default_group = branch

    if save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
#      @parent_groups = [parent_group]
      render :action => 'start'
    end

  end

  def stop
    @employee = Employee.find(params[:eid])
    if @employee.status.flag != "1"
      redirect_to :controller => 'data', :index => 'index'
    end
    @job = JobHistory.new
#    @branches = [@current_group]
  end

  def create_stop
    @employee = Employee.find(params[:eid])
    @job = JobHistory.new(params[:job_history])
#    @branches = [@current_group]

    branch = @employee.status.branch
    group = @employee.status.branch.external
    team = nil

    @job.employee = @employee

    @job.history_type = 'stop'

    @job.source_branch = @employee.status.branch
    @job.source_group = @employee.status.group
    @job.source_team = @employee.status.team

    @job.target_branch = branch
    @job.target_group = group
    @job.target_team = team

    @employee.status.branch = branch
    @employee.status.group = group
    @employee.status.team = team
    @employee.status.flag = 0

    @employee.default_group = branch

    if save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
#      @parent_groups = [parent_group]
      render :action => 'stop'
    end
  end

  def idel
    @employee = Employee.find(params[:eid])
    if @employee.status.flag != "1"
      redirect_to :controller => 'data', :index => 'index'
    end
    @job = JobHistory.new
#    @branches = [@current_group]
  end

  def create_idel
    @employee = Employee.find(params[:eid])
    @job = JobHistory.new(params[:job_history])
#    @branches = [@current_group]

    branch = @employee.status.branch
    group = @employee.status.branch.idel
    team = nil

    @job.employee = @employee

    @job.history_type = 'idel'

    @job.source_branch = @employee.status.branch
    @job.source_group = @employee.status.group
    @job.source_team = @employee.status.team

    @job.target_branch = branch
    @job.target_group = group
    @job.target_team = team

    @employee.status.branch = branch
    @employee.status.group = group
    @employee.status.team = team
    @employee.status.flag = 2

    @employee.default_group = branch

    if save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
#      @parent_groups = [parent_group]
      render :action => 'idel'
    end
  end

  def change
    @employee = Employee.find(params[:eid])
    if @employee.status.flag != "1"
      redirect_to :controller => 'data', :index => 'index'
    end
    @job = JobHistory.new
#    @branches = [@current_group]
  end

  def create_change
    @employee = Employee.find(params[:eid])
    @job = JobHistory.new(params[:job_history])
#    @branches = [@current_group]

    branch = Group.find(params[:group_filter][:branch]) unless params[:group_filter][:branch].empty?
    group = Group.find(params[:group_filter][:group]) unless params[:group_filter][:group].empty?
    team = Group.find(params[:group_filter][:site]) unless params[:group_filter][:site].empty?

    @job.employee = @employee

    @job.history_type = 'change'

    @job.source_branch = @employee.status.branch
    @job.source_group = @employee.status.group
    @job.source_team = @employee.status.team

    @job.target_branch = branch
    @job.target_group = group
    @job.target_team = team

    @employee.status.branch = branch
    @employee.status.group = group
    @employee.status.team = team

    @employee.default_group = branch

    if save
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
#      @parent_groups = [parent_group]
      render :action => 'change'
    end
  end

  def query_changes
    name = params[:id]
    sql = CustomQueryGenerator.generate_sql(name, params[:search])
    sql = sql.gsub('__group', @current_group.id.to_s)
    @result = ActiveRecord::Base.connection.execute(sql)
  end


  private

  def get_branches
    if @current_group.eql?(Group.root)
      @branches = UnitBranch.find(:all)
    else
      @branches = [@current_group]
    end
  end

  def save
    begin
      Employee.transaction do
        @employee.save!
        @employee.status.save!
        @job.save!
        true
      end
    rescue
      false
    end
  end

end
