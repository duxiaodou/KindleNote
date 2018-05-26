class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      
      t.text :title
      t.text :describe
      t.numeric :rating
      t.timestamps
    end
  end
end
