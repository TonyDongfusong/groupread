class CreateReadRecords < ActiveRecord::Migration
  def change
    create_table :read_records do |t|
      t.belongs_to :user
      t.belongs_to :book
      t.integer :rating
      t.string :status
      t.timestamps
    end
    reversible do |dir|
      dir.up do
        execute <<-EOF
          alter table read_records add constraint book_user_unique unique (book_id, user_id);
        EOF
      end
      dir.down do
      end
    end
  end
end
