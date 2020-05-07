class AddOriginfilePathColumnToSlides < ActiveRecord::Migration[6.0]
  def change
    add_column :slides, :originfile_path, :string
  end
end
