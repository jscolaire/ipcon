class VlansController < ApplicationController
  $log = Log4r::Logger.new("vlans")
  $log.add(LOGFILE)
  def index
    @vlans = Vlan.paginate(:order => "tag", :page => params[:page])
  end
end
