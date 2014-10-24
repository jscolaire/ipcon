module VlansHelper
  def vlans_actions
    [
      { :key => :add, :name => name_for_button("plus"),
      :url => new_vlan_path,
        :options => { :if => Proc.new { logged_in? },
                      :container_class => 'btn-group',
                      :class => "btn",
                      :title => "Nueva vlan" }
      },
      { :key => :print, :name => name_for_button("print"),
      :url => url_for("vlans.pdf"),
      :options => { :class => 'btn',
                    :title => "Print vlans managed" }
      }
    ]
  end
end
