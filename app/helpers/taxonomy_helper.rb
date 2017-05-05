module TaxonomyHelper
  def taxontypes_actions
    [
      { :key => :add, :name => name_for_button("plus"),
        :url => '/taxonomy/new',
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "Nuevo tipo" }
        },
      { :key => :edit, :name => name_for_button("edit"),
        :url => "/taxonomy/edit/#{session[:taxontype].id}",
        :options => { :if => Proc.new { logged_in? and Taxontype.all.length != 0 },
                      :container_class => 'btn-group',
                      :class => 'btn',
                      :title => 'Editar tipo' } },
      { :key => :destroy, :name => name_for_button("trash"),
        :url => "/taxonomy/delete/#{session[:taxontype].id}",
        :options => { :if => Proc.new { logged_in? and session[:taxontype] != nil },
                      :method => :delete,
                      :confirm => "¿ Estás seguro de borrar este tipo de taxonomía ?",
                      :class => 'btn', :title => "Borrar tipo" } },
    ]
  end

  def taxontype_actions
     a = [
      { :key => :add, :name => name_for_button("plus"),
        :url => new_taxon_path,
        :options => { :if => Proc.new { logged_in? and Taxontype.all.length != 0 },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "Nuevo taxon" }
      }
    ]

    if session[:taxon_parents] != nil
      b = [
        { :key => :edit, :name => name_for_button("edit"),
          :url => edit_taxon_path(session[:taxon_parents].last),
          :options => { :if => Proc.new { logged_in? and Taxontype.all.length != 0 },
                        :container_class => 'btn-group',
                        :class => "btn",
                        :title => "Editar taxon" }
        },
        { :key => :destroy, :name => name_for_button("trash"),
          :url => taxon_path(session[:taxon_parents].last),
          :options => { :if => Proc.new { logged_in? and session[:taxontype] != nil },
                        :method => :delete,
                        :confirm => "¿ Estás seguro de borrar este tipo de taxonomía ?",
                        :class => 'btn', :title => "Borrar tipo" } },
      ]

      return a + b
    else
      return a
    end

      #{
        #:key => :edit, :name => name_for_button("edit"),
        #:url => edit_taxon_path
      #}
    #]
  end
end