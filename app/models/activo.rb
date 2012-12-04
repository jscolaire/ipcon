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

  def match(tags)
    if tags.class != Array
      $log.error "Passed parametes is not array"
      $log.info "Forcing to true matching Activo"
      return true
    end
    negative_tags = Array.new
    match = "(.*)"
    nomatch = "(.*)"
    tags.sort.each {|t|
      if t.chars.first == "!"
        nomatch << t.sub(/^!/,"") << "(.*)"
        negative_tags.push t.sub(/^!/,"")
      else
        match << t << "(.*)"
      end
    }
    if negative_tags.count > 0
      # any match excludes activo
      negative_tags.each { |nt|
        return false if self.raw_tags_list.match(/(.*)#{nt}(.*)/)
      }
      # now must match with positives matches
      self.raw_tags_list.match(match)
    else
      self.raw_tags_list.match(match)
    end
  end

end
