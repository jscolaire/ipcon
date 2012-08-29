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
      session[:user_username] = user.username
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

  def edit
    $log.info("Editing user #{session[:user_id]}")
    @user = User.find(session[:user_id])
    $log.info("User #{session[:user_id]} is #{@user.username}")
    render :action => 'edit', :layout => 'login'
  end

  def update
    user = User.authenticate(session[:user_username],params[:old_password])
    if ! user
      $log.error("Old password invalid, aborting edition of user")
      flash.now[:error] = "Invalid old password"
      render :action => 'edit', :layout => 'login'
      return
    end
    $log.info("Trying change password to user #{user.username}")
    if user.update_attributes(
      :password => params[:password],
      :password_confirmation => params[:password_confirmation])
      redirect_to_target_or_default root_url, :flash => { :success => "Password changed successfully." }
    else
      user.errors.each do |e|
        $log.debug e
        flash.now[:error] = "Field #{e[0]} #{e[1]}"
      end
      render :action => 'edit', :layout => 'login'
    end
  end
end
