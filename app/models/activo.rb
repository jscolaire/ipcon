class Activo < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :sips
  belongs_to :activo
  default_scope :order => "name"

  has_and_belongs_to_many :tags, :order =>  'tag'

  def to_s
    name
  end

  def parents
    a = Array.new
    a.push([name,id.to_s])
    return a
  end

  def raw_tags_list
    tl = ""
    tags.each {|t|
      tl << t.tag + ", "
    }
    return tl.sub(/, $/,'')
  end

  def title
    return raw_tags_list if description == nil
    description + " - " + raw_tags_list
  end

  def update_tags(tags)
    # borramos todas las asociaciones
    $log.info "Updating tags"
    ActivoTag.delete_all("activo_id = #{id}")
    tags.strip.sub(/,$/,'')
    tags.split(",").each {|tag|
      t = Tag.find_or_create_by_tag(tag.strip)
      ActivoTag.new(:activo_id => id,:tag_id => t.id).save
    }
  end

end
