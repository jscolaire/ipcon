module VlansHelper
  def vlans_actions
    [
      :key => :print, :name => name_for_button("print"),
      :url => url_for('print'),
      :options => { :class => 'btn',
                    :title => "Print vlans managed" }
    ]
  end
end
