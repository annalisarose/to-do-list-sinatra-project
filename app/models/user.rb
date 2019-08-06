class User < ActiveRecord::Base
  has_many :lists
  has_many :checkitems, through: :lists
end
