module ActivosHelper
  def activos_actions
    [
      :key => :print, :name => name_for_button("print"),
      :url => url_for('print'),
      :options => { :class => 'btn',
                    :title => "Print vlans managed" }
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
