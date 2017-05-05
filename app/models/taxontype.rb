class Taxontype < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name

  before_validation :normalize

	has_many :taxons, 
    :conditions => ["taxon_id = ?",-1],
		:dependent => :delete_all,
		:order => :name

  def normalize
    self.name = self.name.strip
  end

  def to_s
    self.name
  end
end