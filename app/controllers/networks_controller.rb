class NetworksController < ApplicationController

  before_filter :login_required, :except => [ :index, :show ]
  before_filter :store_target_location, :except => [ :edit,:update ]
  $log = Log4r::Logger.new("network")
  $log.add(LOGFILE)

  def index
    $log.info("Requested list networks")
    @networks = Network.paginate(:order => "prefix", :page => params[:page])
    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
    end
  end

  def show
    $log.debug("Requested show network #{params[:id]}")
    @network = Network.find(params[:id])
    $log.info("Network #{params[:id]} is #{@network.name}")
    @ips = @network.sips
    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
    end
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
        flash[:info] = 'La red ha sido creada correctamente.'
        format.html { redirect_to(@network) }
      else
        $log.error("Network wasn't successfully created.")
        flash[:error] = "La red no ha podido ser creada."
        format.html { render :action => "new", :layout => 'application' }
      end
    end
  end

  def update
    @network = Network.find(params[:id])
      if @network.update_attributes(params[:network])
        flash[:info] = 'La red ha sido actualizada correctamente'
        redirect_to session[:return_to]
      else
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
    $log.debug("Switching status for #{ip}")
    if !ip.assigned
      ip.assigned = true
    else
    ip.free
    end
    ip.save!
    $log.debug "Rendering now"
    #ip.assigned = !ip.assigned
    #ip.save
    #redirect_to "/networks/#{ip.network.id}##{ip.ip}"
    redirect_to "#{network_path(ip.network.id)}##{ip.id}"
    #render
  end

  def resolv
    #TODO: deberíamos evitar el consultar mediante un comando y hacerlo con ruby,
    #ahora es necesario instalar el paquete bind9-hosts
    network = Network.find(params[:id])
    network.sips.each {|ip|
      cmd = "host #{ip}| grep -i name | awk -F: '{ print $2 }'"
      #hostname = `host #{ip.ip} | grep -i name | awk -F: '{ print $2 }'`.strip
      hostname = %x[ host #{ip} ].strip
      if ! hostname.match("not found")
        ip.hostname = hostname.split.last.sub(/.$/,'')
        ip.save
      end
    }
    redirect_to network
  end


end
