class AddCoulmToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :link, :string
    add_column :events, :coverimg_path, :string
  end
end
