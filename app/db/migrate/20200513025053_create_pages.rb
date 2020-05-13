class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :path
      t.references :slide, null: false, foreign_key: true

      t.timestamps
    end
  end
end
