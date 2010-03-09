class Yat::QueryController < Yat::SecurityController
  def index
  end

  def group(id=params[:node])
    respond_to do |format|
      format.html # render static index.html.erb
      format.json { render :json => Group.find_children(id) }
    end
  end

  def menu
    r = Role.find_by_id(1)
    fs = r.features

    m = []
    m1 = {}

    fs.each do |f|
      if f.level%100 == 0
        if m1.empty?
          m1 = { :xtype => 'splitbutton', :text => f.name, :iconCls => 'no-icon'}
        else
          m << m1
          m1 = { :xtype => 'splitbutton', :text => f.name, :iconCls => 'no-icon'}
        end
      else
        m1[:menu] = [] if m1[:menu].nil?
        m1[:menu] << { :text => f.name, :handler => "---handleAction.createCallback('#{uri(f)}')---" }
      end
    end

    m << m1

    @menu = m.to_json.gsub("\"---", "").gsub("---\"", "")
  end

  private

  def uri(f)
    uri_options = {}
    uri_options[:controller] = '/' + f.controller_name unless f.controller_name.nil?
    uri_options[:action] = f.action_name unless f.action_name.nil?
    uri_options[:code_scope] = f.code_scope unless f.code_scope.nil?
    url_for(uri_options)
  end
end