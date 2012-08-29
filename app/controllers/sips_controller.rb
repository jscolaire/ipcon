class SipsController < ApplicationController
  before_filter :login_required
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

    #si hemos rellenado el campo activo lo asignamos o creamos
    if params[:activo]
      @ip.activo = Activo.find_or_create_by_name(params[:activo][:name])
      #params[:ip][:activo_id] = activo.id
    end
    respond_to do |format|
      if params[:gw] or params[:hpsrp] or params[:temporal] or @ip.activo != nil
        @ip.assigned = true
      end
      if @ip.update_attributes(params[:ip])
        @ip.save!
        flash[:notice] = 'Network was successfully updated.'
        rt = session[:return_to]
        rt = "#{network_path(@ip.network.id)}##{@ip.ip}" if rt == nil
        format.html { redirect_to(rt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ip.errors, :status => :unprocessable_entity }
      end
    end
  end

end
