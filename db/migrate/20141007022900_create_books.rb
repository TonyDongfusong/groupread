class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :title
      t.string :image
      t.string :url
      t.index(:book_id, unique: true)
      t.index(:image, unique: true)
      t.index(:url, unique: true)

      t.timestamps
    end
  end
end
