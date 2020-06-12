class CreatePageMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :page_moves do |t|
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
