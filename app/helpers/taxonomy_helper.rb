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
      { :key => :add, :name => name_for_button("plus-sign"),
        :url => new_taxon_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "Nuevo taxon" }
        },
      { :key => :edit, :name => name_for_button("edit"),
        :url => "/taxonomy/edit/#{session[:taxontype].id}",
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => 'btn',
                      :title => 'Editar tipo' } },
      { :key => :destroy, :name => name_for_button("trash"),
        :url => "/taxonomy/delete/#{session[:taxontype].id}",
        :options => { :if => Proc.new { logged_in? },
                      :method => :delete,
                      :confirm => "¿ Estás seguro de borrar este tipo de taxonomía ?",
                      :class => 'btn', :title => "Borrar tipo" } },
    ]
  end
end
