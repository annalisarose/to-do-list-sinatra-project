class List < ActiveRecord::Base
  belongs_to :user
  has_many :checkitems
  #accepts_nested_attributes_for :checkitems

  def slug
    title.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    List.all.find{|l| l.slug == slug}
  end

end
