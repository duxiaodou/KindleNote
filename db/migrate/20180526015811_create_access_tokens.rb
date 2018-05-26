class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.belongs_to :user, index: true
      t.text :name
      t.text :title
      t.text :access_token
      t.text :openid
      t.text :scopes
      t.timestamp :expires
      t.boolean :revoked

      t.timestamps
    end
  end
end
