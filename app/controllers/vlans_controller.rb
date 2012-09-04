class VlansController < ApplicationController
  $log = Log4r::Logger.new("vlans")
  $log.add(LOGFILE)
  def index
    @vlans = Vlan.paginate(:order => "tag", :page => params[:page])
    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
    end
  end
end
