class NetworksController < ApplicationController

  $log = Log4r::Logger.new("network")
  $log.add(LOGFILE)

  def index
    $log.debug("requested list networks")
    @networks = Network.all
    @actions = networks_actions
  end

  def show
    $log.debug("requested show network #{params[:id]}")
    @network = Network.find(params[:id])
    $log.info("network #{params[:id]} is #{@network.name}")
    @ips = @network.ips
    $log.debug("generating actions for network #{params[:id]}")
    @actions = network_actions
  end

  def new
    @network = Network.new

    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def edit
    @network = Network.find(params[:id])
  end

  def create
    @network = Network.new(params[:network])

    respond_to do |format|
      if @network.save
        flash[:notice] = 'Network was successfully created.'
        format.html { redirect_to(@network) }
      else
        flash[:error] = "Network wasn't successfully created."
        format.html { render :action => "new", :layout => 'application' }
      end
    end
  end

end
