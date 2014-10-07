class CreateReadRecords < ActiveRecord::Migration
  def change
    create_table :read_records do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :rating
      t.string :status

      t.timestamps
    end
  end
end
