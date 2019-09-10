class List < ActiveRecord::Base
  belongs_to :user
  has_many :checkitems
  #accepts_nested_attributes_for :checkitems

  def slug
    title.to_s.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find { |l| l.slug == slug}
  end

end
