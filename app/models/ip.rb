class Ip < ActiveRecord::Base
  belongs_to :network
  belongs_to :activo

  def to_s
    return ip if network == nil
    ip + "/" + network.netmask.to_s
  end
end
