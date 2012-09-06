class SearchController < ApplicationController
  $log = Log4r::Logger.new("search")
  $log.add(LOGFILE)
  def index
    if params[:query].to_s.blank?
      $log.warn "Query is blank"
      redirect_to session[:return_to]
      return
    end
    $log.info "Query: #{params[:query]}"
    query = "%" + params[:query] + "%"
    @activos = Activo.where(
      "name like ? or description like ?",
      query,query
    )

    @ips = Sip.where(
      "ip like ? or hostname like ? or label like ?",
      query,query,query
    )

    if @activos.length == 0 and @ips.length == 0
      render :text => "<p>No hay resultados coincidentes con los parámetros de búsqueda</p>",
        :layout => 'application'
    end

  end
end
