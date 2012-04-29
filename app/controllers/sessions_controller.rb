class SessionsController < ApplicationController

  $log = Log4r::Logger.new("sessions")
  $log.add(LOGFILE)

  def new
    $log.debug("requested login")
    render :action => 'new', :layout => 'login'
  end

  def create
    $log.info("Trying log for user #{params[:login]}")
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :flash => { :success => "Logged in successfully." }
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new', :layout => 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :flash => { :info => "You have been logged out." }
  end
end
