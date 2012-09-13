class Sip < ActiveRecord::Base
  set_table_name "ips"

  belongs_to :network
  belongs_to :activo

  before_save :setassigned

  def setassigned
    self.assigned = false
    if !self.hostname.blank? or
        self.gw or self.temporal or self.reserved or
        self.activo_id != nil or self.hpsrp or
        !self.label.blank? or
        self.gw_id != nil

      self.assigned = true
    end
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
