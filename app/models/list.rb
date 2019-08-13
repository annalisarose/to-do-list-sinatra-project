class List < ActiveRecord::Base
  belongs_to :user
  has_many :checkitems
  #accepts_nested_attributes_for :checkitems

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods


end
