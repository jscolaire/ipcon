#encoding : utf-8
module NetworksHelper
  def networks_actions
    [
      { :key => :add, :name => name_for_button("plus"),
        :url => new_network_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "Nueva red" }
        },
        { :key => :print, :name => name_for_button("print"),
          :url => url_for('networks.pdf'),
          :options => { :container_class => 'btn-group',
                        :class => 'btn',
                        :title => 'Imprimir redes'} }
    ]
  end

  def network_actions
    [
      { :key => :edit, :name => name_for_button("edit"),
        :url => edit_network_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => 'btn',
                      :title => 'Edit' } },
      { :key => :resolv, :name => name_for_button("eye-open"),
        :url => url_for(:action => 'resolv', :id => @network),
        :options => { :if => Proc.new { logged_in? },
                    :class => 'btn',
                    :title => 'Resuelve hostname en DNS' } },
      #{ :key => :split, :name => name_for_button("resize-small"),
        #:url => url_for(:action => 'split'),
        #:options => { :if => Proc.new { logged_in? },
                      #:class => 'btn',
                      #:title => "Split net in two subnets" } },
      { :key => :destroy, :name => name_for_button("trash"),
        :url => network_path,
        :options => { :if => Proc.new { logged_in? },
                      :method => :delete,
                      :confirm => "¿ Estás seguro de borrar la red ?",
                      :class => 'btn', :title => "Delete" } },
      { :key => :print, :name => name_for_button('print'),
        :url => url_for("#{network_path}.pdf"),
        :options => { :class => 'btn',
                      :title => "Print" } },
      { :key => :export, :name => name_for_button('arrow-down'),
        :url => url_for("#{network_path}.xls"),
        :options => { :class => 'btn',
                      :title => 'Export'} }
    ]
  end
end
