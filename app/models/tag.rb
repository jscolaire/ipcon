#encoding : utf-8
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :activos, :order => 'name'

  def to_s
    return tag
  end

  def raw_activos_list
    al = ""
    activos.each {|a|
      al << a.name + ", "
    }
    return al.sub(/, $/,'')
  end

end
