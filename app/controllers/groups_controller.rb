class GroupsController < SecurityController
  def index
    @groups = @current_group.full_set()
  end
  
  def new
    @parent_groups = []
    @parent_groups << Group.find_by_id(params[:parent_id])
    @group = Group.new

  end

  def create
    parent_group = Group.find(params[:group][:parent_id])

    if save(parent_group, params[:group])
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
      @parent_groups = [parent_group]
      render :action => 'new'
    end

    expire_fragment(:controller => 'query')
  end

  def edit
    @group = Group.find(params[:id])
    if @group.parent.nil?
      @parent_groups = []
    else
      parent_group = @group.parent
      @parent_groups = [parent_group]
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[@group.type.to_s.underscore])
      flash[:notice] = I18n.t("action_Save_Success")
      redirect_to :action => "custom"
    else
      parent_group = Group.find(params[:group][:parent_id])
      @parent_groups = [parent_group]
      render :action => 'edit'
    end

    expire_fragment(:controller => 'query')
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.children.empty?
      @group.destroy
    end
    redirect_to :action => "custom"

    expire_fragment(:controller => 'query')
  end

  def full
    @groups = @current_group.full_set()
  end

  def results
    if is_empty(params[:search])
      redirect_to :action => "full"
    else
      params[:search]['Group__lft'] = @current_group.lft
      params[:search]['Group__rgt'] = @current_group.rgt
      super
    end
  end

  private

  def is_empty(h)
    h.each do |k, v|
      return false if !v.empty?
    end
    
    return true
  end

  def save(parent, kvs)
    case parent
    when UnitCompany
      @group = UnitBranch.new(kvs)
      @group.lv = 2
    when UnitBranch
      @group = UnitGroup.new(kvs)
      @group.lv = 4
    when UnitGroup
      @group = UnitTeam.new(kvs)
      @group.lv = 6
    end

    Group.transaction do
      if @group.save
        @group.move_to_child_of(parent)
        if @group.kind_of?(UnitBranch)
          external = UnitExternal.create
          external.move_to_child_of(@group)
          idel = UnitIdel.create
          idel.move_to_child_of(@group)
        end
        true
      else
        @error_group = @group
        @group = Group.new(kvs)

        false
      end
    end
  end
end
