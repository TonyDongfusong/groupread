class CreateDoubanAuthInfos < ActiveRecord::Migration
  def change
    create_table :douban_auth_infos do |t|
      t.string :access_token
      t.string :douban_user_name
      t.string :douban_user_id
      t.integer :expires_in
      t.string :refresh_token
      t.references :user
      t.index(:douban_user_id, unique: true)
      t.index(:douban_user_name, unique: true)

      t.timestamps
    end
  end
end
