class Yat::SecurityController < ApplicationController
  before_filter :authorize, :except => [:login, :logout]

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:loginUsername], params[:loginPassword])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        uri = '/yat/query/dummy' if uri.nil?
        session[:menu_data] = get_menu(user)
        render :json => { :success => true, :uri => uri }
      else
        render :json => { :success => false, :errors => { :reason => I18n.t("loginform_InvalidPassword") } }
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = I18n.t("loginform_Logout");
    redirect_to(:action => "login")
  end

  protected

  def authorize
    session[:original_uri] = request.request_uri
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user
#      flash[:notice] = I18n.t("loginform_LoginPrompt");
#      redirect_to :controller => :security, :action => :login
      redirect_to '/yat/security/login'
      return
    end

    if @current_user.default_group.nil?
      @current_group = Group.root
    else
      @current_group =@current_user.default_group
    end
  end


  def get_menu(user)
    r = user.roles[0]
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

    return m.to_json.gsub("\"---", "").gsub("---\"", "")
  end

  def uri(f)
    uri_options = {}
    uri_options[:controller] = '/' + f.controller_name unless f.controller_name.nil?
    uri_options[:action] = f.action_name unless f.action_name.nil?
    uri_options[:code_scope] = f.code_scope unless f.code_scope.nil?
    url_for(uri_options)
  end
end
