class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :twitter_uid
      t.string :icon_path

      t.timestamps
    end
  end
end
