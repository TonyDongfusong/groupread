class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :douban_id
      t.string :douban_email

      t.timestamps
    end
  end
end
