class UpgradeNetworks < ActiveRecord::Migration
  def up
    Network.all.each {|n|
      n.prefix = "#{n.prefix}#{n.network}/#{n.netmask}"
      n.save
    }

    remove_column :networks, :gw_id
    remove_column :networks, :network
    remove_column :networks, :netmask
    remove_column :networks, :bcast
    remove_column :networks, :last
    remove_column :networks, :first
    remove_column :networks, :hosts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
