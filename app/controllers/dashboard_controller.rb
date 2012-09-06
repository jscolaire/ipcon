class DashboardController < ApplicationController
  before_filter :store_target_location
  layout 'application'
  $log = Log4r::Logger.new("dashboard")
  $log.add(LOGFILE)
  def index
    $log.info("Entering dashboard")
    @networks = Network.count
    @ocupacion = 0
    Network.all.each {|n|
      @ocupacion += n.ocupacion
    }
    @ocupacion = (@networks != 0 ? @ocupacion / @networks : 0)
    @activos = Activo.count
    @ips = Sip.count
    @vlans = Vlan.count
  end
end
