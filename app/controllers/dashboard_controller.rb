class DashboardController < ApplicationController
  layout 'application'
  def index
    @networks = Network.all.length
    @ocupacion = 0
    Network.all.each {|n|
      @ocupacion += n.ocupacion
    }
    @ocupacion = @ocupacion / @networks
    @activos = Activo.all.length
    @ips = Ip.all.length
  end
end
