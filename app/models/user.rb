# encoding: utf-8
require 'digest'

class User < ActiveRecord::Base
  has_one :douban_auth_info
  has_and_belongs_to_many :groups
  has_many :read_records

  attr_accessor :password

  validates :password, :presence => {:message => "密码不能为空"},
            :confirmation => {:message => "两次输入的密码不一致"},
            :length => { :within => 6..40, too_short: "最少6个字符", too_long: "最多40个字符"}
  validates :email, :presence => {:message => "邮箱不能为空"}
  validates :email, :uniqueness => {:message => "该邮箱已经被占用了"}
  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                      :message => "邮箱格式不对"

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password) if password
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
