class SetAssigned < ActiveRecord::Migration
  def self.up
    execute %{
      update ips set assigned="t" where (temporal=="t" or hpsrp=="t" or gw=="t")
    }
  end

  def self.down
    puts "Nothing to do"
  end
end
