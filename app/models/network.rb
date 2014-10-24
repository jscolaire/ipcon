class Network < ActiveRecord::Base
  $log = Log4r::Logger.new("network model")
  $log.add(LOGFILE)

  before_create :setup
  after_create :setips

  validates_uniqueness_of :prefix
  validates_presence_of :name

  has_many :sips,
    :dependent => :delete_all

  has_one :gateway,
    :class_name => "Sip",
    :foreign_key => "gw_id"

  belongs_to :vlan

  def checkSubnet
  end

  def setup

    # set prefix to NetAddr format
    begin
    self.prefix = NetAddr::CIDR.create(self.prefix).to_s
    rescue
      errors.add(:prefix,"La red proporcionada no es válida")
      return false
    end
    # check if prefix is a existing subnet from networks
    Network.all.each {|n|
      if NetAddr::CIDR.create(n.prefix).contains?(self.prefix)
        errors.add(:prefix,"This prefix is part of other network")
        return false
      end
    }
    true
  end

  def setips
    net = NetAddr::CIDR.create(self.prefix)
    net.range(1,net.size-2).each {|ip|
      # Ip class is my class, whereas IP is ruby-ip class
      Sip.new(:network_id => id,:ip => ip).save
    }
  end

  def to_s
    NetAddr::CIDR.create(prefix).to_s
  end

  def range
    net = NetAddr::CIDR.create(prefix)
    return net[1].ip + " - " + net[net.size-2].ip
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
    NetAddr::CIDR.create(prefix).broadcast
  end

  def hosts
    NetAddr::CIDR.create(prefix).size
  end

  # alias for gateway
  def gw
    self.gateway
  end

  def ocupacion
    ((ipsocup=Sip.all(:conditions => "network_id = #{id} and assigned='t'").length)*100) / (sips.size - 1)
  end

  def bits
    NetAddr::CIDR.create(prefix).bits
  end

  def human
    net = NetAddr::CIDR.create(prefix)
    "#{net.network}/#{net.wildcard_mask}#{net.netmask}"
  end
end
