class RolifyCreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table(:permissions) do |t|
      t.string :name
      t.string :title

      t.timestamps
    end

    create_table(:permissions_roles, :id => false) do |t|
      t.references :permission
      t.references :role

      t.timestamps
    end
    
    add_index(:permissions, :name)
    add_index(:permissions_roles, [ :permission_id, :role_id ])
  end
end
