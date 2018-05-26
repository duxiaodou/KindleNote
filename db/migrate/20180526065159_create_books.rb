class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.numeric :rating
      t.text :describe
      
      t.timestamps
    end
  end
end
