class ActivosController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :store_target_location, :except => [:edit, :update]
  $log = Log4r::Logger.new("activo")
  $log.add(LOGFILE)
  # GET /activos
  # GET /activos.xml
  def index
    #@activos = Activo.all(:order => 'name')
    @activos = Activo.paginate(:page => params[:page])
    $log.debug "Activos is #{@activos.class}"

    respond_to do |format|
      format.html # index.html.erb
      format.pdf { render :pdf =>  @activos = Activo.order("name"), :layout => false  }
      #format.xml  { render :xml => @activos }
    end
  end

  # GET /activos/1
  # GET /activos/1.xml
  def show
    @activo = Activo.find(params[:id])

    @ips = @activo.sips

    respond_to do |format|
      format.html # show.html.erb
      format.pdf { render :layout => false }
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
    @taxontypes = Taxontype.all
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
    $log.info("Trying update #{@activo}")
    @activo.update_tags(params[:activo][:raw_tags_list]) if params[:activo][:raw_tags_list] != nil
    params[:activo].delete :raw_tags_list
    puts "===================================="
    puts "===================================="
    puts "===================================="
    puts "===================================="
    puts params
    $log.info params
    respond_to do |format|
      if @activo.update_attributes(params[:activo])
        flash[:success] = 'Activo modificado correctamente.'
        format.html { redirect_to(session[:return_to]) }
      else
        format.html { render :action => "edit" }
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

