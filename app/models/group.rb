class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def contain_user user
    users.any? do |user_in_group|
      user_in_group.id == user.id
    end
  end
end
