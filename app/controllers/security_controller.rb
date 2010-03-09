class SecurityController < ApplicationController
  before_filter :authorize, :except => [:login, :logout]

  layout 'yat'
  
  def index
  end

  def custom
    if params[:id].nil?
      name = controller_name.singularize + '_query'
    else
      name = params[:id]
    end
    view = CustomQueryGenerator.generate_view(name)
#    render :inline => view, :layout => "application"
    render :inline => view, :layout => "yat"
  end

  def results
    name = params[:id]
    sql = CustomQueryGenerator.generate_sql(name, params[:search])
    sql = sql.gsub('__group', @current_group.id.to_s)
    @result = ActiveRecord::Base.connection.execute(sql)
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })
      else
        flash.now[:notice] = I18n.t("loginform_InvalidPassword");
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = I18n.t("loginform_Logout");
    redirect_to(:action => "login")
  end

  #@user=CGI::Session::ActiveRecordStore::Session.find_by_session_id(@session_id).data[:user]
  def active_users
    @active_users = Array.new
    user_sessions = CGI::Session::ActiveRecordStore::Session.find( :all ) #:conditions => [ 'updated_at > ?', Time.now() - 10.minutes ]
    user_sessions.each do |user_session|
      session_data = Marshal.load( Base64.decode64( user_session[:data] ) )
      @active_users << User.find_by_id(session_data[:user_id])
    end
  end

  protected

  def authorize
    session[:original_uri] = request.request_uri
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user
      flash[:notice] = I18n.t("loginform_LoginPrompt");
      redirect_to :controller => :security, :action => :login
      return
    end
    
    if @current_user.default_group.nil?
      @current_group = Group.root
    else
      @current_group =@current_user.default_group
    end
  end
end
