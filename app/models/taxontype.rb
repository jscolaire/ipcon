class Taxontype < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name

  before_validation :normalize

  def normalize
    self.name = self.name.strip
  end

end
