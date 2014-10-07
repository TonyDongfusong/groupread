class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :title
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
