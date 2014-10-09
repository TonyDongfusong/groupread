class UserGroupAssociation < ActiveRecord::Migration
  def change
    create_table :groups_users, id: false do |t|
      t.belongs_to :group
      t.belongs_to :user
    end
    reversible do |dir|
      dir.up do
        execute <<-EOF
          alter table groups_users add constraint group_user_unique unique (group_id, user_id);
        EOF
      end
      dir.down do
      end
    end
  end
end
