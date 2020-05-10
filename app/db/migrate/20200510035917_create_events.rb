class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :close_at

      t.timestamps
    end
  end
end
