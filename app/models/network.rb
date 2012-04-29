class Network < ActiveRecord::Base

#validates_uniqueness_of :network
  validates_presence_of :name

  has_many :ips,
    :dependent => :delete_all

  has_one :gateway,
    :class_name => "Ip",
    :foreign_key => "network_id"

  belongs_to :vlan

  def before_create

    prefix =""
    self.netmask = self.prefix.split("/")[1]
    self.prefix.split(".")[0..2].each {|p|
      prefix << p + "."
    } 
    self.network = self.prefix.split(".").last
    self.prefix = prefix
    if self.netmask == nil
      self.netmask = 24
    end
    self.hosts = 2**(32 - self.netmask) - 2
    self.first = self.network + 1
    self.last = self.first + self.hosts - 1
    self.bcast = self.first + self.hosts

  end

  def after_create
    create_ips(first,last)
  end

  def to_s
    prefix + network.to_s + "/" + netmask.to_s
  end

  def range
    prefix + first.to_s + " - " + prefix + last.to_s
  end

  def split
    mask = (self.netmask + 1).to_s
    prefix = self.prefix + self.network.to_s + "/" + mask
    n1 = Network.new(
      :prefix => prefix,
      :name => self.name + "-1"
      )
    n1.save

    for i in 0..n1.ips.length-1
      n1.ips[i].hostname = self.ips[i].hostname
      n1.ips[i].network_id = n1.id
      n1.ips[i].save
    end

    prefix = n1.prefix + (n1.bcast + 1).to_s + "/" + mask
    n2 = Network.new(
      :prefix => prefix,
      :name => self.name + "-2"
    )
    n2.save
    offset = 1 + self.hosts / 2
    for i in 0..n2.ips.length-1
      n2.ips[i].hostname = self.ips[i+offset].hostname
      n2.ips[i].network_id = n2.id
      n2.ips[i].save
    end
    self.delete
  end

  def broadcast
    prefix + bcast.to_s
  end

  # alias for gateway
  def gw
    self.gateway
  end

  # ocupacion
  def ocupacion
    ((ipsocup=Ip.all(:conditions => "network_id = #{id} and assigned='t'").length)*100) / (ips.size - 1)
  end

  private
  def create_ips(first,last)
    for i in first..last
      Ip.new(:ip => self.prefix + i.to_s,
          :network_id => self.id).save
    end
  end

end
