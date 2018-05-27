class CreateFragments < ActiveRecord::Migration[5.2]
  def change
    create_table :fragments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :note, index: true

      t.text :content
      t.string :category
      t.string :datetime
      
      t.timestamps
    end
  end
end
