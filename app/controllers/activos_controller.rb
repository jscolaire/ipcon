class ActivosController < ApplicationController
  before_filter :login_required, :except => ['index','show']
  # GET /activos
  # GET /activos.xml
  def index
    #@activos = Activo.all(:order => 'name')
    @activos = Activo.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      #format.html {
        #render :partial => 'activos',
               #:layout => 'application-sb'
      #}
      format.xml  { render :xml => @activos }
    end
  end

  # GET /activos/1
  # GET /activos/1.xml
  def show
    store_location
    @activo = Activo.find(params[:id])

    breadcrumbs(
        @activo.parents << ["Activos","../activos"])

    @ips = @activo.ips

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activo }
    end
  end

  # GET /activos/new
  # GET /activos/new.xml
  def new
    @activo = Activo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activo }
    end
  end

  # GET /activos/1/edit
  def edit
    @activo = Activo.find(params[:id])
  end

  # POST /activos
  # POST /activos.xml
  def create
    @activo = Activo.new(params[:activo])
    @activo.os = "desconocido"

    respond_to do |format|
      if @activo.save
        flash[:notice] = 'Activo was successfully created.'
        format.html { redirect_to(@activo) }
        format.xml  { render :xml => @activo, :status => :created, :location => @activo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activos/1
  # PUT /activos/1.xml
  def update

    @activo = Activo.find(params[:id])
    @activo.update_tags(params[:tags]) if params[:tags] != nil
    respond_to do |format|
      if @activo.update_attributes(params[:activo])
        flash[:notice] = 'Activo was successfully updated.'
        format.html { redirect_to(session[:return_to]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activos/1
  # DELETE /activos/1.xml
  def destroy
    @activo = Activo.find(params[:id])
    @activo.destroy

    respond_to do |format|
      format.html { redirect_to(activos_url) }
      format.xml  { head :ok }
    end
  end

  def edit_on_line
    @activo = Activo.find(params[:id])
    @activo_sup = Activo.new
    begin
      @activo_sup = Activo.find(@activo.activo_id)
    rescue
    end
    @field = params[:field]
    render :partial => 'edit_on_line', :layout => false
  end
end

