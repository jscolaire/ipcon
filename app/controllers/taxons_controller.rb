class TaxonsController < ApplicationController
  before_filter :store_target_location, :except => [ :edit,:new, :create, :update]
  $log = Log4r::Logger.new("taxon")
  $log.add(LOGFILE)
  # GET /taxons
  # GET /taxons.json
  def index
    redirect_to :taxonomy
  end

  # GET /taxons/1
  # GET /taxons/1.json
  def show
    @taxon = Taxon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taxon }
    end
  end

  # GET /taxons/new
  # GET /taxons/new.json
  def new
    $log.info("requesting new taxon of #{session[:taxontype]}")
    @taxon = Taxon.new
    @taxon.taxontype_id = session[:taxontype].id
    begin
      @taxon.taxon = session[:taxon_parents].last
    rescue
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /taxons/1/edit
  def edit
    @taxon = Taxon.find(params[:id])
  end

  # POST /taxons
  # POST /taxons.json
  def create
    $log.debug params
    $log.info("trying create a new taxon of #{session[:taxontype]}")
    #this method creates problems whith hierarchy
    #@taxon = Taxon.new(params[:taxon])
    @taxon = Taxon.new()
    @taxon.name = params[:taxon][:name]
    #@taxon.taxontype_id = params[:taxon][:taxontype_id]
    @taxon.taxontype_id = session[:taxontype].id
    @taxon.parent = params[:taxon][:parent]
    respond_to do |format|
      if @taxon.save
        if @taxon.parent != nil
        format.html { redirect_to taxontypes_path(:id => @taxon.parent.id), notice: 'Taxon was successfully created.' }
        else
        format.html { redirect_to taxontypes_path, notice: 'Taxon was successfully created.' }
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /taxons/1
  # PUT /taxons/1.json
  def update
    @taxon = Taxon.find(params[:id])

    respond_to do |format|
      if @taxon.update_attributes(params[:taxon])
        format.html { redirect_to @taxon, notice: 'Taxon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @taxon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxons/1
  # DELETE /taxons/1.json
  def destroy
    @taxon = Taxon.find(params[:id])
    @taxon.destroy

    respond_to do |format|
      format.html { redirect_to taxons_url }
      format.json { head :no_content }
    end
  end
end
