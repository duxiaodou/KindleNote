class AddClippingAndAvatarToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :clipping, :file
    add_column :users, :avatar, :file
  end
end
