class List < ActiveRecord::Base
  belongs_to :user
  has_many :checkitems
  #accepts_nested_attributes_for :checkitems

  def slug
    title.to_s.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    List.all.find { |l| l.slug == slug}
  end


#  def user_find_by_slug(slug)
#    User.all.find{|user| user.slug == slug}
#  end

end
