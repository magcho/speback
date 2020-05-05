class CreateSlides < ActiveRecord::Migration[6.0]
  def change
    create_table :slides do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :close_at

      t.timestamps
    end
  end
end
