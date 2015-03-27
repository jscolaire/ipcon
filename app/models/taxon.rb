class Taxon < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :parent
  attr_accessible :taxontype_id

  belongs_to :taxon
  has_many :taxons

  #has_many :activos

  validates_presence_of :name
  validate :unique_nombre


  def unique_nombre
    if self.taxon == nil
      if Taxon.where("name = ? and taxontype_id = ?",self.name,self.taxontype_id) != nil
        errors.add(:name,"Este nombre ya existe para este tipo de taxonomía")
      end
    else
      $log.debug("Validating name, parent is #{self.parent}")
      $log.debug("Looking for name = #{self.name} and taxon_id = #{self.taxon_id}")

      $log.debug(Taxon.where("name = ? and taxon_id = ?",self.name,self.taxon_id))

      if Taxon.where("name = ? and taxon_id = ?",self.name,self.taxon_id).length != 0
        errors.add(:name,"Este nombre ya existe para el taxón del que depende")
      end
    end
  end

  def parent
    return nil if taxon == nil
    taxon
  end

  def parents
    return [self] if taxon == nil
      a = taxon.parents
      a.push self
      return a
  end

  def parent=(p)
    $log.debug self.inspect
    $log.debug("parent is #{p}")
    $log.debug("I am #{self.name} and my taxontype_id is #{taxontype_id}")
    tp = t = nil
    p.strip.split("->").reverse.each do |p|
      $log.debug("procesing #{p}")
      t = Taxon.find_or_create_by_name(p.strip)
      t.taxontype_id = self.taxontype_id
      t.save
      if tp != nil
        t.taxon = tp
      end
      tp = t
      $log.debug("now parent is #{tp.name}")
    end
    self.taxon = t
    #Taxon.find_or_create_by_name(self.parent)
  end

  def to_s
    name
  end

end
