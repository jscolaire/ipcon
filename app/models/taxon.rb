class Taxon < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :parent
  attr_accessible :taxontype_id

  belongs_to :taxon
  has_many :taxons

  validates_presence_of :name

  def parent
    return "" if taxon == nil
    taxon.name
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

end