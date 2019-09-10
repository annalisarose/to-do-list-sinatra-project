class User < ActiveRecord::Base
  has_many :lists
  has_many :checkitems, through: :lists

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find { |l| l.slug == slug}
  end

end
