class TaxonomyController < ApplicationController
  before_filter :store_target_location, :except => [ :edit,:new, :create, :update]
  $log = Log4r::Logger.new("taxonomy")
  $log.add(LOGFILE)
  def index
    $log.debug("Entering on taxonomy controller")
    @types = Taxontype.all
    if @types.length == 0
      $log.debug "deleting session[:taxontype]"
      session[:taxontype] = Taxontype.new
    else
      session[:taxontype] = @types.first if session[:taxontype] == nil
    end
    if params[:id] == nil
      $log.debug("No hay parámetros, vamos al índice general de taxonomía")
      @taxons = Taxon.where("taxontype_id = ? and taxon_id isnull",session[:taxontype].id) if session[:taxontype] != nil
      session[:taxon_parents] = nil
    else
      session[:taxon_parents] = Taxon.find(params[:id]).parents
      @taxons = Taxon.where("taxontype_id = ? and taxon_id = ?",session[:taxontype].id,params[:id])
    end
  end

  def new
    $log.info("Requesting new taxonomy type")
    @type = Taxontype.new

    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def create
    $log.info("Creating #{params[:taxontype][:name]} as type of taxonomy")
    @type = Taxontype.new(params[:taxontype])

    respond_to do |format|
      if @type.save
        $log.info("Created #{@type.name} as type of taxonomy successfully")
        flash[:info] = "El tipo de taxonomía ha sido creado correctamente"
        format.html { redirect_to('/taxonomy') }
        session[:taxontype] = @type
      else
        $log.error("Type of taxonomy wasn't created successfully")
        flash[:error] = @type.errors[:name].first
        format.html { redirect_to('/taxonomy/new') }
      end
    end
  end

  def show
    $log.info("showing type of taxonomy #{params[:id]}")
    session[:taxontype] = Taxontype.find(params[:id])
    redirect_to '/taxonomy'
  end

  def delete
    $log.info("deleting type of taxonomy #{params[:id]}")
    #TODO relation for destroy taxons of this taxonomytype
    Taxontype.delete(params[:id])
    session[:taxontype] = Taxontype.all.first
    redirect_to '/taxonomy'
  end

  def edit
    $log.info("editing type of taxonomy #{params[:id]}")
    @type = Taxontype.find(params[:id])
    $log.info("editing type of taxonomy #{@type}")
  end

  def update
    $log.info("updating type of taxonomy #{session[:taxontype]}")
    $log.debug(params)
    $log.debug("I want to put #{params[:taxontype]} on taxonomytype")

    if session[:taxontype].update_attributes(params[:taxontype])
      $log.info("#{@type} has updated successfully")
      flash[:info] = "El tipo de taxonomía ha sido actualizado"
      redirect_to session[:return_to]
    end
  end
end
