class QueryController < ApplicationController
  def index
    r = Group.root
    @branches = r.children
  end

  # filter
  def filter_by_branch
    if params[:branch_id].empty?
      @groups = []
    else
      r = Group.find(params[:branch_id])
      @groups = r.children
      @groups.delete_if { |g| g.lv.nil?}
    end
    render :partial => 'share/group_list', :layout => false
  end

  def filter_by_group
    if params[:group_id].empty?
      @sites = []
    else
      r = Group.find(params[:group_id])
      @sites = r.children
      @sites.delete_if { |g| g.lv.nil?}
    end
    render :partial => 'share/site_list', :layout => false
  end

  def find_employees
    #    if params[:id].nil?
    #      if session[:filter_group].nil?
    #        @group = Group.root
    #      else
    #        @group = Group.find(session[:filter_group])
    #      end
    #    else
    #      @group = Group.find(params[:id])
    #    end
    #
    #    session[:filter_group] = @group.id

    @view = CustomQueryGenerator.generate_view('employees_query')

    @display = params[:display].nil? ? (session[:display].nil? ? 'picture' : session[:display]) : params[:display]
    session[:display] = @display

    ## Get result
    if params[:page].nil?
      if !params[:search].nil?
        sql = CustomQueryGenerator.generate_sql('employees_query', params[:search])
        if @display == 'picture'
          @employees = Employee.paginate_by_sql(sql, :page => params[:page], :per_page => 8, :include => [:photo])
        elsif @display == 'text'
          @employees = Employee.paginate_by_sql(sql, :page => params[:page], :per_page => 30)
        end
      end
    else
      sql = session[:filter_sql]
      if @display == 'picture'
        @employees = Employee.paginate_by_sql(sql, :page => params[:page], :per_page => 8, :include => [:photo])
      elsif @display == 'text'
        @employees = Employee.paginate_by_sql(sql, :page => params[:page], :per_page => 30)
      end
    end

    session[:filter_sql] = sql
    #    if request.post? || request.put?
    #      raise params[:employee].inspect
    #      @employee = Employee.new(params[:employee])
    #      @employees = Employee.paginate :page => params[:page], :per_page => 20, :order => 'id ASC'
    #    else
    #      @employee = Employee.new
    #    end
  end

  def display
    @display = params[:display].nil? ? (session[:display].nil? ? 'picture' : session[:display]) : params[:display]
    session[:display] = @display
  end

  def list
    #    case session[:style]
    #    when 'text'
    #      render :action => "list_with_text", :layout => false
    #    when 'picture'
    #      render :action => "list_with_picture", :layout => false
    #    else
    #      render :action => "list_with_text", :layout => false
    #    end
    if params[:id].nil?
      @group = Group.root
    else
      @group = Group.find(params[:id])
    end

    @id = @group.id

    @display = params[:display].nil? ? (session[:display].nil? ? 'picture' : session[:display]) : params[:display]
    session[:display] = @display

    if @display == 'picture'
      @employees = Employee.paginate :page => params[:page], :per_page => 8, :include => [:photo], :conditions => "default_group_id = #{@id}", :order => 'id ASC'
      render :action => 'list_with_picture', :layout => false
    elsif @display == 'text'
      #      @employees = Employee.paginate :page => params[:page], :per_page => 30, :include => [:branch, :job], :conditions => "default_group_id = #{@id}", :order => 'id ASC'
      @employees = Employee.paginate :page => params[:page], :per_page => 30, :conditions => "default_group_id = #{@id}", :order => 'id ASC'
      render :action => 'list_with_text', :layout => false
    end
  end

  def list_with_picture

  end
  def list_with_text

  end

  def info
    @employee = Employee.find(params[:id])
    render :action => 'info', :layout => 'clean'
  end

  def search
    #    @id = params[:id]
    #    @group = Group.find(@id)

    @display = params[:display].nil? ? (session[:display].nil? ? 'picture' : session[:display]) : params[:display]
    session[:display] = @display

    @cd = "1=1"
    if params[:name].length != 0
      @cd << " and name like '%#{params[:name]}%'"
    end
    if params[:id_card_number].length != 0
      @cd << " and id_card_number = " + params[:id_card_number]
    end
    if params[:employee_number].length != 0
      @cd << " and employee_number = " + params[:employee_number]
    end
    if params[:min_years].length != 0
      @cd << " and (year(now()) - year(birthdate)) >= " + params[:min_years]
    end
    if params[:max_years].length != 0
      @cd << " and (year(now()) - year(birthdate)) < " + params[:max_years]
    end

    if @display == 'picture'
      @employees = Employee.paginate :page => params[:page], :per_page => 8, :include => [:photo], :conditions => @cd, :order => 'id ASC'
      render :action => 'list_with_picture'
    elsif @display == 'text'
      @employees = Employee.paginate :page => params[:page], :per_page => 30, :conditions => @cd, :order => 'id ASC'
      render :action => 'list_with_text'
    end
  end

  def custom
    name = params[:name]
    view = CustomQueryGenerator.generate_view(name)
    render :inline => view, :layout => "query"
  end

  def results
    name = params[:name]
    sql = CustomQueryGenerator.generate_sql(name, params[:search])
    @result = ActiveRecord::Base.connection.execute(sql)
  end
end
