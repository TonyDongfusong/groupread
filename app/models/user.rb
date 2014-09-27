class User < ActiveRecord::Base
  attr_accessor :repeated_password, :douban_id
  has_one :douban_auth_info

end
