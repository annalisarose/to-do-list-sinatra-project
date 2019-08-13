class User < ActiveRecord::Base
  has_many :lists
  has_many :checkitems, through: :lists

  has_secure_password

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods


end
