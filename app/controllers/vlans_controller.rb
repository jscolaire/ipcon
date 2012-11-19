class VlansController < ApplicationController
  $log = Log4r::Logger.new("vlans")
  $log.add(LOGFILE)
  before_filter :login_required, :except => [ :index, :show ]
  before_filter :store_target_location, :except => [ :edit,:update ]
  def index
    $log.info "Requested list vlan"
    @vlans = Vlan.paginate(:order => "tag", :page => params[:page])
    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
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
  end
end
