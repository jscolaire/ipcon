#encoding : utf-8
class TagsController < ApplicationController

  before_filter :login_required, :except => [ :index, :show ]
  before_filter :store_target_location, :except => :edit
  $log = Log4r::Logger.new("tags")
  $log.add(LOGFILE)

  def index
    @tags = Tag.all(:order => 'tag')

    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
      format.xml { render :xml => @tags }
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @activos = @tag.activos

    respond_to do |format|
      format.html
      format.pdf { render :layout => false }
      format.xml { render :xml => @tag }
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml { head :ok }
    end

  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      flash[:success] = "La etiqueta ha sido modificada correctamente"
      redirect_to(session[:return_to])
    else
      render :action => 'edit'
    end
  end

  def tag2pdf
    tag = Tag.find(params[:id])
    pdf = Prawn::Document.new do
      font "Helvetica", :size => 8
      text "Servicio de Informática - Departamento de Sistemas - #{Time.now.strftime('%d/%m/%Y')}"
      text "Listado de activos asociados a la etiqueta #{tag}", :size => 16

      move_down 25

      text "Activos asociados #{tag.activos.length}", :size => 16

      data = Array.new

      tag.activos.each {|activo|
        data.push [ activo.name,activo.description]
      }

      if data.length == 0
        text "Esta etiqueta no tiene activos asignados"
      else
        font "Helvetica", :size => 8
        table data, :headers => ["Activo","Descripción"],
          :row_colors => :pdf_writer,
          :font_size => 10,
          :border_width => 0,
          :width => margin_box.width,
          :columns_widths => { 2 => 450 }
      end

    end

    send_data pdf.render, :filename => "#{tag}-activos.pdf", :type => 'application/pdf'
  end
end
