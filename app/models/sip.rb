class Sip < ActiveRecord::Base
  set_table_name "ips"

  belongs_to :network
  belongs_to :activo

  #before_create :setip

  def setip
    self.ip = IP.new(self.ip)
  end

  def to_s
    return ip
  end

  def free
    self.hostname = nil
    self.gw = false
    self.temporal = false
    self.reserved = false
    self.activo_id = nil
    self.hpsrp = false
    self.label = nil
    self.gw_id = nil
    self.assigned = false
  end
end
