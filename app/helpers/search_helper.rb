module SearchHelper
  def search_actions
    [
        { :key => :print, :name => name_for_button("print"),
          :url => url_for('search_print'),
          :options => { :container_class => 'btn-group',
                        :class => 'btn',
                        :title => 'Imprimir redes'} }
    ]
  end
end
