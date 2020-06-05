class AddCoulumnCurrentPresenterPageNumToSlides < ActiveRecord::Migration[6.0]
  def change
    add_column :slides, :current_presenter_page_num, :int
  end
end
