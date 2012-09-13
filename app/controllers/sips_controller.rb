class SipsController < ApplicationController
  before_filter :login_required
  $log = Log4r::Logger.new("ip")
  $log.add(LOGFILE)
  def edit
    @ip = Sip.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'login' }
      format.xml  { render :xml => @ip }
    end
  end

  # PUT /networks/1
  # PUT /networks/1.xml
  def update
    @ip = Sip.find(params[:id])
    $log.info "Updating IP #{@ip.ip}"

    #si hemos rellenado el campo activo lo asignamos o creamos
    if !params[:sip][:activo].to_s.blank?
      $log.debug "activo is #{params[:sip][:activo]}"
      @ip.activo = Activo.find_or_create_by_name(params[:sip][:activo])
    end
    params[:sip].delete :activo

    #si hemos marcado como gateway ponemos el número de red
    if params[:sip][:gw_id].to_i == 1
      $log.info "Setting gateway for #{@ip.network}"
      params[:sip][:gw_id] = @ip.network.id
    else
      $log.info "Removing gateway for #{@ip.network}"
      params[:sip][:gw_id] = nil
    end
    if @ip.update_attributes(params[:sip])
      flash[:sucess] = 'La IP ha sido actualizada correctamente.'
      rt = session[:return_to]
      rt = "#{network_path(@ip.network.id)}##{@ip.ip}" if rt == nil
      redirect_to(rt)
    else
      render :action => "edit"
    end
  end

end
