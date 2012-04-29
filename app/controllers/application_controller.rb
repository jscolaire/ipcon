class ApplicationController < ActionController::Base
  include ControllerAuthentication

  layout 'application-sb'
  protect_from_forgery

  before_filter :check_login

  $log = Log4r::Logger.new("appctrl")
  $log.add(LOGFILE)

  def check_login
    $log.debug "target location stored in #{session[:return_to]}"
    $log.debug "valuating check_login"
    if logged_in?
      $log.debug "you are logged in"
      @login_items = [
        { :key => :profile,
          :name => "<i class='icon-user icon-white'></i>&nbsp;#{current_user.username}",
          :url => "/user/edit",
          :options => { :container_class => 'nav pull-right' } },
          { :key => :logout, :name => "Logout", :url => "/logout",
            :options => { :container_class => 'nav pull-right' } }
      ]
    else
      $log.debug "you are logged out, please log in"
      @login_items = [
        :key => :login, :name => "Login", :url => "login",
        :options => { :container_class => 'nav pull-right' }
      ]
      $log.debug @login_items.to_s
    end
    return @login_items
  end

  def networks_actions
    [
      { :key => :add, :name => name_for_button("plus"),
        :url => new_network_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "New network" }
        },
        { :key => :print, :name => name_for_button("print"),
          :url => url_for(:action => 'print'),
          :options => { :container_class => 'btn-group',
                        :class => 'btn',
                        :title => 'Print network'} }
    ]
  end

  def network_actions
    [
      { :key => :edit, :name => name_for_button("edit"),
        :url => network_path,
        :options => { :container_class => 'btn-group', :class => 'btn', :title => 'Edit' } },
      { :key => :split, :name => name_for_button("resize-small"),
        :url => url_for(:action => 'split'),
        :options => { :class => 'btn', :title => "Split net in two subnets" } },
      { :key => :print, :name => name_for_button('print'),
        :url => url_for(:action => 'print'),
        :options => { :class => 'btn', :title => "Print" } }
    ]
  end

  private
  # make a html button for action
  # icon is the icon of Glyphicons we want
  # see Twitter bootstrap for a list of icons
  def name_for_button(icon)
    "<i class='icon-#{icon}'></i>"
  end
end
