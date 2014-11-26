class TaxonomyController < ApplicationController
  before_filter :store_target_location, :except => [ :edit,:new ]
  $log = Log4r::Logger.new("taxonomy")
  $log.add(LOGFILE)
  def index
    $log.debug("Entering on taxonomy controller")
    @types = Taxontype.all
    session[:taxontype] = @types.first if session[:taxontype] == nil
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
    Taxontype.delete(params[:id])
    session[:taxontype] = Taxontype.all.first
    redirect_to '/taxonomy'
  end
end
