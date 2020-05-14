class ForSlidePagesToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :page_num, :integer
    rename_column :pages, :path, :img
  end
end
