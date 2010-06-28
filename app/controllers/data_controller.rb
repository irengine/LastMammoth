class DataController < SecurityController
  layout 'data'

  def view
    logger.info '-----------------'
    logger.info @current_group.name
    logger.info '-----------------'
    @teams = ''
    @teams << '['
    @current_group.children.each do |c|
      next if c.instance_of?(UnitExternal) || c.instance_of?(UnitIdel)
      @teams << '{'
      @teams << "branch_name: \'#{c.name}\', "
      @teams << 'groups: ['
      @teams << get_team(c)
      @teams << ']'
      @teams << '},'
    end
    @teams << '{'
    @teams << "branch_name: \'#{@current_group.idel.name}\', "
    @teams << 'groups: ['
    @teams << get_group(@current_group.idel)
    @teams << ']'
    @teams << '}'
    @teams << ']'

    respond_to do |format|
      format.json { render :json => @teams }
    end
  end

  def index
  end

  def get_group(g)
    teams = '' 
        teams << '{' << "group_name: \'\',"
        teams << "begin_date: \'\',"
        teams << "end_date: \'\',"
        teams << "quantity: \'\',"
        teams << 'employees: ['
        employees = ''
        g.employees_in_group.each do |re|
          employees << '{' << "employee_name: \'#{re.employee.name}\',"
          employees << "employee_id: \'#{re.employee.id}\',"
          employees << "employee_url: \'#{photo_for(re.employee)}\'" << '},'
        end
        employees = employees.chop unless employees.empty?
        teams << employees 
        teams << ']'
        teams << '}'

    return teams
  end
  def get_team(c)
    teams = '' 
    c.children.each do |g|
        teams << '{' << "group_name: \'#{g.name}\',"
        teams << "begin_date: \'#{g.begin_date}\',"
        teams << "end_date: \'#{g.end_date}\',"
        teams << "quantity: \'#{g.quantity}\',"
        teams << 'employees: ['
        employees = ''
        g.employees_in_team.each do |re|
          employees << '{' << "employee_name: \'#{re.employee.name}\',"
          employees << "employee_id: \'#{re.employee.id}\',"
          employees << "employee_url: \'#{photo_for(re.employee)}\'" << '},'
        end
        employees = employees.chop unless employees.empty?
        teams << employees 
        teams << ']'
        teams << '}'
    end

    return teams
  end

  def photo_for(employee, size = :medium)
    if employee.photo
      employee.photo.public_filename
    else
      "/images/blank-photo-#{size}.png"
    end
  end
end
