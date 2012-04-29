class Vlan < ActiveRecord::Base
  has_many :networks, :dependent => :nullify

  validates_presence_of :tag
  validates_numericality_of :tag

  def to_s
    tag.to_s + " - " + name
  end
end
