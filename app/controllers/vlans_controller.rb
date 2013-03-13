class VlansController < ApplicationController
  $log = Log4r::Logger.new("vlans")
  $log.add(LOGFILE)
  before_filter :login_required, :except => [ :index, :show ]
  before_filter :store_target_location, :except => [ :new,:edit,:update ]
  def index
    $log.info "Requested list vlan"
    @vlans = Vlan.paginate(:order => "tag", :page => params[:page])
    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
    end
  end

  # GET /vlans/new
  # GET /vlans/new.xml
  def new
    @vlan = Vlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vlan }
    end
  end
  # POST /vlans
  # POST /vlans.xml
  def create
    @vlan = Vlan.new(params[:vlan])

    respond_to do |format|
      if @vlan.save
        flash[:notice] = 'La vlan fue creada correctamente'
        format.html { redirect_to(vlans_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def edit
    #$log.debug("Editando vlan #{params[:id]}")
    @vlan = Vlan.find(params[:id])
  end

  def update
    $log.info "Modificando vlan #{params[:id]}"
    @vlan = Vlan.find(params[:id])
    if @vlan.update_attributes(params[:vlan])
      flash[:info] = 'La vlan ha sido actualizada correctamente'
      redirect_to session[:return_to]
    else
    end
  end

  def destroy
    $log.info "Borrando vlan #{params[:id]}"
    Vlan.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to(vlans_url) }
      format.xml  { head :ok }
    end

  end
end
