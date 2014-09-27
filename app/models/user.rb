class User < ActiveRecord::Base
  attr_accessor :repeated_password, :douban_id
  has_one :douban_auth_info
  has_and_belongs_to_many :groups

end
