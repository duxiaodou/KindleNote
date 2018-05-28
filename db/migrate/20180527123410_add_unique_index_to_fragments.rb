class AddUniqueIndexToFragments < ActiveRecord::Migration[5.2]
  def change
    add_index :fragments, [:user_id, :note_id, :content, :datetime] , :name => 'unique_index_fragments', :unique => true
  end
end
