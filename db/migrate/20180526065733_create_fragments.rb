class CreateFragments < ActiveRecord::Migration[5.2]
  def change
    create_table :fragments do |t|

      t.timestamps
    end
  end
end
