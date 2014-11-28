class Taxon < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :parent

  attr_accessor :parent

  belongs_to :taxon
  has_many :TaxonsController

  validates_presence_of :name

  before_save :check

  def check
    self.taxon = nil if self.parent == nil
    Taxon.find_or_create_by_name(self.parent)
  end

  def parent
    return "" if taxon == nil
  end
end
