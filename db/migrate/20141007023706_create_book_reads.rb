class CreateBookReads < ActiveRecord::Migration
  def change
    create_table :books_users do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :rating
      t.string :status

      t.timestamps
    end
  end
end
