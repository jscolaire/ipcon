#encoding : utf-8
class Vlan < ActiveRecord::Base
  has_many :networks, :dependent => :nullify

  validates_presence_of :tag
  validates_numericality_of :tag
  validates_presence_of :name

  def to_s
    tag.to_s + " - " + name
  end

end
