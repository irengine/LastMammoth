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

  def test
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
end
