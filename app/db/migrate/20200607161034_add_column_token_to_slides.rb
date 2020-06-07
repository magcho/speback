class AddColumnTokenToSlides < ActiveRecord::Migration[6.0]
  def change
    add_column :slides, :token, :string
    add_index :slides, :token, unique: true
  end
end
