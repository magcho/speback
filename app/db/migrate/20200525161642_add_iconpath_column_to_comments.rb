class AddIconpathColumnToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :icon_url, :string
    add_column :comments, :tweet_id, :string
    add_index :comments, :tweet_id, unique: true
  end
end
