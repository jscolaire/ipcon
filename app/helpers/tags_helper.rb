module TagsHelper

  def tags_actions
    [
      :key => :print, :name => name_for_button("print"),
      :url => url_for('tags.pdf'),
      :options => { :class => 'btn',
                    :title => "Print vlans managed" },
    ]
  end

  def tag_actions
    [
      { :key => :print, :name => name_for_button("print"),
        :url => url_for("#{tag_path}.pdf"),
        :options => { :class => 'btn',
                      :title => 'Imprimir la etiqueta seleccionada' }},
      { :key => :edit, :name => name_for_button("edit"),
      :url => edit_tag_path(@tag),
      :options => { :if => Proc.new { logged_in? },
                    :class => 'btn',
                    :title => "Editar etiqueta" } },
      { :key => :delete, :name => name_for_button("trash"),
      :url => url_for(:action => 'delete'),
      :options => { :if => Proc.new { logged_in? },
                    :class => 'btn',
                    :title => 'Borrar la etiqueta seleccionada' } }
    ]
  end

  def activos_list(tag)
    al = ""
    tag.activos.each {|a|
      al << link_to(h(a),a) + ", "
    }
    return al.sub(/, $/,'')
  end

  def tags_cloud
    #hay 6 tamaños
    #.xxs .xs .s .l .xl .xxl
    frecuency = ActivoTag.find_by_sql(
      "select count(*) as frec,tag_id from activos_tags group by tag_id order by frec")
    tags_size = Hash.new
    maxstep = (frecuency.length / 6).to_i + 1
    step = 1
    size = 1
    #si hay pocas etiquetas
    maxstep = 1 if frecuency.length < 6
    size = 4 if frecuency.length < 6
    frecuency.each {|f|
      tags_size[f.tag_id] = [size,f.frec]
      step += 1
      if step > maxstep
        step = 1
        size += 1 if frecuency.length > 6
      end
    }
    tags = ""
    Tag.all(:order => 'tag').each {|tag|
      style = "bad"
      next if tags_size[tag.id] == nil #tag sin activos asociados (frecuencia=0)
      case tags_size[tag.id][0]
      when 1
        style = "xxs"
      when 2
        style = "xs"
      when 3
        style = "s"
      when 4
        style = "l"
      when 5
        style = "xl"
      when 6
        style = "xxl"
      end


      tags << link_to(h(tag),tag,:class => style,
                      :title => "#{tags_size[tag.id][1]} activos asociados") << "&nbsp;\n"
    }
    return tags
  end

end
