class NetworksController < ApplicationController

  before_filter :login_required, :except => [ :index, :show ]
  before_filter :remove_location, :only => [ :index,:show ]
  $log = Log4r::Logger.new("network")
  $log.add(LOGFILE)

  def index
    $log.info("Requested list networks")
    @networks = Network.order("prefix")
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def show
    $log.debug("Requested show network #{params[:id]}")
    @network = Network.find(params[:id])
    $log.info("Network #{params[:id]} is #{@network.name}")
    @ips = @network.sips
  end

  def new
    $log.debug "Requested creating new network"
    @network = Network.new

    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def edit
    @network = Network.find(params[:id])
  end

  def create
    $log.info("Trying for create a network #{params[:network][:prefix]}")
    @network = Network.new(params[:network])

    respond_to do |format|
      if @network.save
        $log.info("Network #{@network} was successfully created.")
        flash[:notice] = 'Network was successfully created.'
        format.html { redirect_to(@network) }
      else
        $log.error("Network #{@network} wasn't successfully created.")
        flash[:error] = "Network wasn't successfully created."
        format.html { render :action => "new", :layout => 'application' }
      end
    end
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy

    respond_to do |format|
      format.html { redirect_to(networks_url) }
      format.xml  { head :ok }
    end
  end

  def switch_status
    ip = Sip.find(params[:id])
    ip.free
    ip.save
    #ip.assigned = !ip.assigned
    #ip.save
    #redirect_to "/networks/#{ip.network.id}##{ip.ip}"
    redirect_to "#{network_path(ip.network.id)}##{ip.ip}"
  end

  def print_url
    network = Network.find(params[:id])

    pdf = Prawn::Document.new do

      font "Helvetica", :size => 8
      text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
      text "Listado de red - #{network.name}", :size => 14

      text "Nombre de red: #{network.name}"
      text "Dirección de red: #{network}"
      text "Broadcast: #{network.broadcast}"
      text "Puerta de enlace: #{network.gw}"
      text "VLAN: #{network.vlan}"

      move_down 25

      data = Array.new

      network.ips.each {|ip|
        data.push [
          ip.ip,
          ip.hostname,
          ip.label ] if ip.assigned
      }

      if data.length == 0
        text "Esta red no tiene IP's asignadas"
      else
        table data,
          :headers => ["IP","Hostname","Descripción"]
      end

    end



    send_data pdf.render, :filename => 'listado.pdf', :type => 'application/pdf'
  end
end
