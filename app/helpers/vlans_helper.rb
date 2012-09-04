module VlansHelper
  def vlans_actions
    [
      :key => :print, :name => name_for_button("print"),
      :url => url_for("vlans.pdf"),
      :options => { :class => 'btn',
                    :title => "Print vlans managed" }
    ]
  end
end
