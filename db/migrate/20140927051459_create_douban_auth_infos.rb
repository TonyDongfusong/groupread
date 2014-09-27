class CreateDoubanAuthInfos < ActiveRecord::Migration
  def change
    create_table :douban_auth_infos do |t|
      t.string :access_token
      t.string :douban_user_name
      t.string :douban_user_id
      t.integer :expires_in
      t.string :refresh_token
      t.integer :user_id

      t.timestamps
    end
  end
end
