class SearchController < ApplicationController
  $log = Log4r::Logger.new("search")
  $log.add(LOGFILE)
  def index
    if params[:query].to_s.blank?
      $log.warn "Query is blank"
      redirect_to session[:return_to]
      return
    end
    @activos = Array.new
    tag = active = false
    tags = Array.new
    $log.info "Query: #{params[:query]}"
    query = params[:query]
    query.split.each {|sq|
      tag = active = false
      sq.split(":").each {|q|
        tags.push q if tag
        tag = true if q == "t" or q == "tag"
      }
    }

    if tag
      query= ""
      tags.sort.each {|t|
        if t.split("!").length == 2
          next
        end
        query << "tag = '" << t << "' or "
      }
      query = query.sub(/ or $/,"")
      $log.debug "Query tags is #{query}"
      candidates = Activo.joins(:tags).where(query).order("name").group(:id)
      $log.info "There are #{candidates.length} candidates"
      candidates.each {|c|
        @activos.push c if c.match(tags.sort)
      }
      $log.info "There are #{@activos.length} actives"
      File.open("tmp/ipcon_activos_searched", "w") { |file|
        # grabamos título y activos
        Marshal.dump(["Listado de activos coincidentes con #{params[:query]}",@activos],file)
      }
    else
      $log.info "Query do not content tags"
      query = "%" + params[:query] + "%"
      $log.debug "Query translated is #{query}"
      @activos = Activo.where(
        "name like ? or description like ?",
        query,query
      )
      $log.debug "there are #{@activos.length} activos"

      @ips = Sip.where(
        "ip like ? or hostname like ? or label like ?",
        query,query,query
      )
      $log.debug "there are #{@ips.length} ips"

    end

    #if (@activos == nil and @ips == nil) or (@activos.length == 0 or ( @ips != nil and @ips.length == 0))
    if (@activos.count == 0 and @ips.count == 0)
      flash[:info] = "No hay resultados coincidentes con los parámetros de búsqueda"
      redirect_to(session[:return_to])
      #render :text => "<p>No hay resultados coincidentes con los parámetros de búsqueda</p>",
      #:layout => 'application'
    end

  end

  def print
    File.open("tmp/ipcon_activos_searched", "r") { |file|
      ary = Marshal.load(file)
  puts ary
      @title = ary[0]
      @activos = ary[1]
    }
    render :template => "activos/index.pdf", :layout => false
  end
end
