class ApplicationController < ActionController::Base
  include ControllerAuthentication
  helper :all

  layout 'application-sb'
  protect_from_forgery

  before_filter :login_items

  $log = Log4r::Logger.new("appctrl")
  $log.add(LOGFILE)

  private

  def remove_location
    session[:return_to] = nil
  end

  def login_items
    if logged_in?
      @login_items = [
        { :key => :profile,
          :name => "<i class='icon-user icon-white'></i>&nbsp;#{current_user.username}",
          :url => "/user/edit",
          :options => { :container_class => 'nav pull-right' } },
          { :key => :logout, :name => "Logout", :url => "/logout",
            :options => { :container_class => 'nav pull-right' } }
      ]
    else
      @login_items = [
        :key => :login, :name => "Login", :url => "/login",
        :options => { :container_class => 'nav pull-right' }
      ]
    end

  end

end
