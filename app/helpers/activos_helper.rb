module ActivosHelper
  def activos_actions
    [
      :key => :print, :name => name_for_button("print"),
      :url => url_for('activos.pdf'),
      :options => { :class => 'btn',
                    :title => "Imprimir activos" }
    ]
  end

  def activo_actions
    [
      { :key => :edit, :name => name_for_button("edit"),
        :url => edit_network_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => 'btn',
                      :title => 'Editar' } },
      { :key => :destroy, :name => name_for_button("trash"),
        :url => activo_path,
        :options => { :if => Proc.new { logged_in? },
                      :method => :delete,
                      :confirm => "¿ Estás seguro de borrar el activo ?" }}
    ]
  end

  def tags_list(activo)
    tl = ""
    activo.tags.each {|t|
      title = "#{ActivoTag.where("tag_id = #{t.id}").count} activos asociados"
      tl << link_to(h(t),t,:class=> "badge badge-info", :title => title) + " "
    }
    return tl.sub(/, $/,'')
  end

end
